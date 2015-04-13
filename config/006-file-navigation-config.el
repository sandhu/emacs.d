(use-package ag :ensure t
  :config (setq ag-highlight-search t
                ag-reuse-buffers t
                ag-reuse-windows t))

(use-package wgrep-ag :ensure t)

(use-package projectile :ensure t
  :bind (("C-x p" . projectile-find-file)
         ("C-x C-p" . projectile-switch-project))
  :diminish projectile-mode)

(use-package recentf
  :init (progn
          (setq recentf-max-saved-items 50)
          (recentf-mode t)

          (defun file-name-with-one-directory (file-name)
            (concat (cadr (reverse (split-string file-name "/"))) "/"
                    (file-name-nondirectory file-name)))

          (defun recentf--file-cons (file-name)
            (cons (file-name-with-one-directory file-name) file-name))

          (defun ido-recentf-open ()
            "Use `ido-completing-read' to \\[find-file] a recent file"
            (interactive)
            (if (find-file
                 (ido-completing-read
                  "Find recent file: "
                  (mapcar 'abbreviate-file-name recentf-list) nil t))
                (message "Opening file...")
              (message "Aborting"))))
  :bind ("C-x f" . ido-recentf-open))
