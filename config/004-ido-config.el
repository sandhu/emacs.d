(use-package ido-completing-read+ :ensure t
  :config
  (ido-mode t)
  (ido-ubiquitous-mode)
  (ido-everywhere t)
  (add-to-list 'ido-ignore-files "\\.DS_Store")
  (add-hook 'ido-setup-hook
            (lambda ()
              (define-key ido-file-completion-map (kbd "~")
                          (lambda ()
                            (interactive)
                            (if (looking-back "/")
                                (insert "~/")
                              (call-interactively 'self-insert-command)))))))

(use-package flx-ido :ensure t
  :init (setq ido-use-faces nil) ; disable ido faces to see flx highlights
  :config (flx-ido-mode t))
