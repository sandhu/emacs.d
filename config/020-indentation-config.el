(use-package whitespace :ensure t
  :init (setq whitespace-style '(face trailing lines-tail tabs)
              whitespace-line-column 80)
  :diminish whitespace-mode)

(use-package auto-indent-mode :ensure t
  :init (setq auto-indent-on-save-file t
              auto-indent-delete-trailing-whitespace-on-save-file t
              auto-indent-untabify-on-save-file t
              auto-indent-indent-style 'aggressive)
  :config (auto-indent-global-mode)
  :diminish auto-indent-mode)
