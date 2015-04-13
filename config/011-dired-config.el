(use-package dired
  :init (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  :bind ("C-x C-d" . dired)
  :config (progn
            (defun dired-back-to-start-of-files ()
              (interactive)
              (backward-char (- (current-column) 2)))

            (defun dired-back-to-top ()
              (interactive)
              (beginning-of-buffer)
              (next-line 2)
              (dired-back-to-start-of-files))

            (defun dired-jump-to-bottom ()
              (interactive)
              (end-of-buffer)
              (next-line -1)
              (dired-back-to-start-of-files))

            (define-key dired-mode-map (vector 'remap 'move-beginning-of-line) 'dired-back-to-start-of-files)

            (define-key dired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
            (define-key dired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)

            ;; Delete with C-x C-k to match file buffers and magit
            (define-key dired-mode-map (kbd "C-x C-k") 'dired-do-delete)))
