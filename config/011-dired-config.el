(use-package dired
  :init (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  :bind ("C-x C-d" . dired)
  :config (define-key dired-mode-map (kbd "C-x C-k") 'dired-do-delete))
