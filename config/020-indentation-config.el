(use-package whitespace :ensure t
  :init (setq whitespace-style '(face trailing lines-tail tabs)
              whitespace-line-column 80)
  :diminish whitespace-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package aggresive-indent :ensure t
  :config (do (global-aggressive-indent-mode 1)
              (add-to-list 'aggressive-indent-excluded-modes 'elisp-mode)))
