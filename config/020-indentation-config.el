(use-package whitespace :ensure t
  :init (setq whitespace-style '(face trailing lines-tail tabs)
              whitespace-line-column 80)
  :diminish whitespace-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package aggressive-indent :ensure t
  :config (progn
            (global-aggressive-indent-mode 1)
            (unbind-key "C-c C-q" aggressive-indent-mode-map))
  :diminish aggressive-indent-mode)
