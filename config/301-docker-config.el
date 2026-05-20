(use-package yaml-mode :ensure t)

(use-package docker :ensure t)

(use-package dockerfile-mode :ensure t
  :hook (dockerfile-mode-hook . (lambda () (aggressive-indent-mode 0))))
