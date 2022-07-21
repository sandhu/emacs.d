(use-package ag :ensure t
  :config (setq ag-highlight-search t
                ag-reuse-buffers t
                ag-reuse-windows t))

(use-package wgrep-ag :ensure t)

(use-package projectile :ensure t
  :bind (("C-x p" . projectile-find-file)
         ("C-x C-p" . projectile-switch-project))
  :diminish projectile-mode)
