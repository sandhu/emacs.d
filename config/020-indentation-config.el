(use-package whitespace :ensure t
  :init (progn
          (setq whitespace-style '(face tabs empty trailing lines-tail))
          (add-hook 'before-save-hook 'whitespace-cleanup))
  :diminish whitespace-mode)

(use-package aggressive-indent :ensure t
  :config (progn
            (add-to-list 'aggressive-indent-excluded-modes 'makefile-mode)
            (global-aggressive-indent-mode 1))
  :diminish aggressive-indent-mode)
