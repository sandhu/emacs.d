(when window-system
  (setq frame-title-format "%f")
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1)
  (menu-bar-mode -1)
  (global-font-lock-mode)
  (window-divider-mode t)
  (desktop-save-mode 1))

(use-package solarized-theme :ensure t
  :init (progn
          (setq solarized-use-less-bold t
                solarized-emphasize-indicators nil
                solarized-scale-org-headlines nil
                x-underline-at-descent-line t)
          (load-theme 'solarized-light 'no-confirm))
  :config (let ((line (face-attribute 'mode-line :underline)))
            (setq color-theme-is-global t)
            (set-face-attribute 'mode-line          nil :overline line)
            (set-face-attribute 'mode-line-inactive nil :overline line)
            (set-face-attribute 'mode-line          nil :underline line)
            (set-face-attribute 'mode-line-inactive nil :underline line)))

(use-package projectile :ensure t)

(defvar-local git-project-text nil)
(defun git-project-text ()
  (setq git-project-text
        (when (and (buffer-file-name) (cdr (project-current)))
          (concat
           " ["
           (file-name-nondirectory (directory-file-name (cdr (project-current))))
           (unless (and (buffer-file-name) (file-remote-p (buffer-file-name)))
             (let* ((branch (shell-command-to-string
                             "git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null"))
                    (branch-str (string-trim (replace-regexp-in-string
                                              "^HEAD" "(DETACHED HEAD)"
                                              branch)))
                    (branch-dirty (shell-command-to-string
                                   "git diff --stat")))
               (concat
                (unless (= 0 (length branch-str))
                  (propertize (concat "  " branch-str) 'face '(:foreground "#444444")))
                (unless (= 0 (length branch-dirty))
                  (propertize "•" 'face font-lock-warning-face)))))
           "]"))))

(defvar-local git-file-text nil)
(defun git-file-text ()
  (setq git-file-text
        (when (and (buffer-file-name) (cdr (project-current)))
          (let* ((diff-str (lambda (cmd)
                             (let ((diff (shell-command-to-string cmd)))
                               (when (and diff (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" diff))
                                 (concat
                                  (propertize (format "+%s"  (match-string 1 diff)) 'face '(:foreground "green4"))
                                  (propertize (format " -%s" (match-string 2 diff)) 'face '(:foreground "red4")))))))
                 (unstaged (funcall diff-str (concat "git diff --numstat -- " (buffer-file-name))))
                 (staged   (funcall diff-str (concat "git diff --cached --numstat -- " (buffer-file-name)))))
            (when (or unstaged staged)
              (concat " ["
                      unstaged
                      (when staged (concat (when unstaged " ") "✓ "))
                      staged
                      "]"))))))

(defvar-local file-directory-text nil)
(defun file-directory-text ()
  (setq file-directory-text
        (propertize
         (or (if (and (buffer-file-name) (cdr (project-current)))
                 (replace-regexp-in-string
                  (concat "^" (cdr (project-current))) ""
                  default-directory)
               (when (buffer-file-name)
                 (replace-regexp-in-string
                  (concat "^" (expand-file-name "~")) "~"
                  default-directory)))
             "")
         'face 'font-lock-keyword-face)))

(defvar-local file-or-buffer-text nil)
(defun file-or-buffer-text ()
  (setq file-or-buffer-text
        (propertize
         (if (buffer-file-name)
             (file-name-nondirectory (buffer-file-name))
           (concat " " (buffer-name)))
         'face 'font-lock-variable-name-face)))

(defvar-local file-save-status-text nil)
(defun file-save-status-text ()
  (setq file-save-status-text
        (when (and (buffer-file-name) (buffer-modified-p))
          (propertize "•" 'face font-lock-warning-face))))

(use-package flycheck
  :ensure t
  :config (setq flycheck-display-errors-delay 0))

(use-package flycheck-inline
  :ensure t
  :init (global-flycheck-inline-mode))

(defvar-local multiple-cursors-text nil)
(defvar-local flycheck-text nil)

(defun update-modeline-text ()
  (let ((left (concat
               git-project-text " "
               file-directory-text
               file-or-buffer-text
               file-save-status-text
               git-file-text " "
               multiple-cursors-text " "
               flycheck-text)))
    (let* ((free-space (- (window-width) (length left) 8))
           (padding (make-string (max 0 free-space) ?\ )))
      (setq mode-line-format (concat left padding "%l:%c"))
      (force-mode-line-update))))

(defun update-flycheck-text (&optional status)
  (setq flycheck-text
        (concat
         "[»"
         (pcase status
           ('finished (if flycheck-current-errors
                          (let-alist (flycheck-count-errors flycheck-current-errors)
                            (when (or .error .warning .info)
                              (concat
                               (propertize (format " %s" (or .error 0)) 'face (when .error 'error))
                               (propertize (format " %s" (or .warning 0)) 'face (when .warning 'warning))
                               (propertize (format " %s" (or .info 0)) 'face (when .info 'info)))))
                        (propertize " ✓" 'face 'success)))
           ('running (propertize " ⋯" 'face 'info))
           ('errored (propertize " ⚠" 'face 'error))
           ('interrupted (propertize " ⏸" 'face 'fringe))
           ('no-checker ""))
         "]"))
  (update-modeline-text))

(defun handle-multiple-cursors ()
  (setq multiple-cursors-text (format "▮%d" (mc/num-cursors))))

(defun update-file-status-text ()
  (git-project-text)
  (file-directory-text)
  (file-or-buffer-text)
  (file-save-status-text)
  (git-file-text)
  (update-modeline-text))

(defun buffer-change-fn (region length)
  (file-save-status-text)
  (update-modeline-text))

(add-hook 'before-change-functions 'buffer-change-fn)
(add-hook 'after-save-hook 'update-file-status-text)

(add-hook 'multiple-cursors-mode-enabled-hook 'handle-multiple-cursors)
(add-hook 'multiple-cursors-mode-disabled-hook (lambda () (setq multiple-cursors-text nil)))

(add-hook 'flycheck-status-changed-functions #'update-flycheck-text)
(add-hook 'flycheck-mode-hook #'update-flycheck-text)

(add-hook 'window-state-change-hook 'update-file-status-text)
(add-hook 'window-configuration-change-hook 'update-file-status-text)
