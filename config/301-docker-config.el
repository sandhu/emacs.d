(use-package yaml-mode :ensure t)

(use-package docker :ensure t)

(use-package dockerfile-mode :ensure t
  :init (setq auto-indent-disabled-modes-list
              (append '(dockerfile-mode conf-unix-mode)
                      auto-indent-disabled-modes-list)))
