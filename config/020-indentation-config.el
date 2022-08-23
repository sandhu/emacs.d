(use-package whitespace :ensure t
  :init (setq whitespace-style '(face trailing tabs))
  :diminish whitespace-mode)

(use-package aggressive-indent :ensure t
  :config (progn
            (add-to-list 'aggressive-indent-excluded-modes 'makefile-mode)
            (global-aggressive-indent-mode 1))
  :diminish aggressive-indent-mode)
