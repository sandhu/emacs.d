(when window-system
  (setq frame-title-format "%f")
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1)
  (menu-bar-mode -1)
  (desktop-save-mode 1))

(use-package solarized-theme :ensure t
  :init (progn
          (setq solarized-high-contrast-mode-line t
                solarized-use-less-bold t
                solarized-emphasize-indicators nil
                solarized-scale-org-headlines nil
                x-underline-at-descent-line t)
          (load-theme 'solarized-light 'no-confirm))
  :config (setq color-theme-is-global t))

(use-package projectile :ensure t)

(defun git-project-message ()
  (when (cdr (project-current))
    (concat
     " ["
     (file-name-nondirectory (directory-file-name (cdr (project-current))))
     (unless (and (buffer-file-name) (file-remote-p (buffer-file-name)))
       (let* ((branch (shell-command-to-string
                       "git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null"))
              (branch-str (string-trim (replace-regexp-in-string
                                        "^HEAD" "(DETACHED HEAD)"
                                        branch))))
         (unless (= 0 (length branch-str))
           (propertize (concat "  " branch-str) 'face '((t :foreground "#444444"))))))
     "]")))

(defun git-file-message ()
  (when (cdr (project-current))
    (let* ((diff-str (lambda (cmd)
                       (let ((diff (shell-command-to-string cmd)))
                         (when (and diff (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" diff))
                           (concat
                            (propertize (format "+%s"  (match-string 1 diff)) 'face '((t :foreground "green4")))
                            (propertize (format " -%s" (match-string 2 diff)) 'face '((t :foreground "red4"))))))))
           (unstaged (funcall diff-str (concat "git diff --numstat -- " (buffer-file-name))))
           (staged   (funcall diff-str (concat "git diff --cached --numstat -- " (buffer-file-name)))))
      (when (or unstaged staged)
        (concat " ["
                unstaged
                (when staged (concat (when unstaged " ") "✓ "))
                staged
                "]")))))

(defun file-directory-message ()
  (propertize
   (if (and (buffer-file-name) (cdr (project-current)))
       (replace-regexp-in-string
        (concat "^" (cdr (project-current))) ""
        default-directory)
     (when (buffer-file-name)
       (replace-regexp-in-string
        (concat "^" (expand-file-name "~")) "~"
        default-directory)))
   'face font-lock-variable-name-face))

(defun file-or-buffer-message ()
  (concat
   (propertize
    (if (buffer-file-name)
        (file-name-nondirectory (buffer-file-name))
      (concat " " (buffer-name)))
    'face font-lock-keyword-face)
   (when (and (buffer-file-name) (buffer-modified-p))
     (propertize "•" 'face font-lock-warning-face))))

(use-package flycheck :ensure t)

(defun flycheck-message ()
  (when (and flycheck-mode flycheck-current-errors)
    (let-alist (flycheck-count-errors flycheck-current-errors)
      (when (or .error .warning)
        (concat
         "[»"
         (propertize (format " %s" (or .error 0)) 'face (when .error 'error))
         (propertize (format " %s" (or .warning 0)) 'face (when .warning 'warning))
         "]")))))

(defun line-column-info ()
  (format "%5s:%-2s" (line-number-at-pos) (current-column)))

(defun setup-minibuffer-modeline ()
  (setq window-divider-default-bottom-width 1
        window-divider-default-places (quote bottom-only))
  (window-divider-mode 1)
  (setq-default mode-line-format nil)
  (walk-windows (lambda (window) (with-selected-window window (setq mode-line-format nil))) nil t))

(defun update-minibuffer-modeline ()
  (let ((minibuf " *Minibuf-0*"))
    (unless (current-message)
      (condition-case err
          (let ((left (concat
                       (git-project-message) " "
                       (file-directory-message)
                       (file-or-buffer-message)
                       (git-file-message) " "
                       (flycheck-message)))
                (right (concat
                        (line-column-info) " ")))
            (with-current-buffer minibuf
              (erase-buffer)
              (let* ((message-truncate-lines t)
                     (max-mini-window-height 1)
                     (free-space (- (frame-width) (length left) (length right)))
                     (padding (make-string (max 0 free-space) ?\ )))
                (insert (concat left (if right (concat padding right)))))))
        (error nil)))))

(setup-minibuffer-modeline)
(update-minibuffer-modeline)

(add-hook 'post-command-hook 'update-minibuffer-modeline)
