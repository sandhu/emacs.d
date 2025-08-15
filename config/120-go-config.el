(use-package go-mode :ensure t
  :config (progn
            (paredit-mode t)
            (setq indent-tabs-mode t
                  tab-width 4)))
