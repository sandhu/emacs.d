(use-package whitespace :ensure t
  :init (setq whitespace-style '(face trailing lines-tail tabs)
              whitespace-line-column 80)
  :diminish whitespace-mode)

(use-package auto-indent-mode :ensure t
  :init (setq auto-indent-indent-style 'aggressive
              auto-indent-on-save-file t
              auto-indent-untabify-on-visit-file t
              auto-indent-delete-trailing-whitespace-on-save-file t
              auto-indent-key-for-end-of-line-then-newline "<M-return>")
  :config (progn
            (auto-indent-global-mode)
            (global-set-key (kbd "RET") auto-indent-newline-function))
  :diminish auto-indent-mode)
