(use-package diff-mode
  :config (progn (setq diff-switches "-u")
                 (set-face-foreground 'diff-added "green4")
                 (set-face-foreground 'diff-removed "red3")))

(use-package magit :ensure t
  :init (progn (setq magit-last-seen-setup-instructions "1.4.0")
               (setq-default magit-save-some-buffers nil
                             magit-process-popup-time 10
                             magit-diff-refine-hunk t
                             magit-completing-read-function 'magit-ido-completing-read)

               (defadvice magit-status (around magit-fullscreen activate)
                 (window-configuration-to-register :magit-fullscreen)
                 ad-do-it
                 (delete-other-windows))

               (defun magit-quit-session ()
                 "Restores the previous window configuration and kills the magit buffer"
                 (interactive)
                 (kill-buffer)
                 (when (get-register :magit-fullscreen)
                   (ignore-errors (jump-to-register :magit-fullscreen)))))
  :bind ("C-x m" . magit-status)
  :config (progn
            (defun magit-ignore-whitespace ()
              (interactive)
              (add-to-list 'magit-diff-options "-w")
              (magit-refresh))

            (defun magit-dont-ignore-whitespace ()
              (interactive)
              (setq magit-diff-options (remove "-w" magit-diff-options))
              (magit-refresh))

            (defun magit-toggle-whitespace ()
              (interactive)
              (if (member "-w" magit-diff-options)
                  (magit-dont-ignore-whitespace)
                (magit-ignore-whitespace)))

            (bind-key "q" 'magit-quit-session magit-status-mode-map)
            (bind-key "C-x C-k" 'magit-kill-file-on-line magit-status-mode-map)
            (bind-key "W" 'magit-toggle-whitespace magit-status-mode-map)))
