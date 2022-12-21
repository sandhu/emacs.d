(use-package company :ensure t
  :init (setq company-idle-delay
              (lambda () (if (company-in-string-or-comment) nil 0.2)))
  :config (global-company-mode)
  :diminish " α")

(use-package company-quickhelp :ensure t
  :config (company-quickhelp-mode))
