(use-package company :ensure t
  :init (setq company-idle-delay 0.2
              company-tooltip-limit 10
              company-minimum-prefix-length 2
              company-tooltip-flip-when-above t)
  :config (global-company-mode 1)
  :diminish " α")

(use-package company-quickhelp :ensure t
  :config (company-quickhelp-mode 1))
