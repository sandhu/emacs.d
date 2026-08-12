;; brew install ripgrep
(use-package rg :ensure t
  :config
  (rg-enable-default-bindings)
  (grep-apply-setting
   'grep-find-command
   '("rg -n -H --no-heading -e '' $(git rev-parse --show-toplevel || pwd)" . 27))
  (global-set-key (kbd "C-x C-g") 'grep-find))

(use-package wgrep :ensure t)

(use-package projectile :ensure t
  :bind (("C-x p" . projectile-find-file)
         ("C-x C-p" . projectile-switch-project))
  :diminish projectile-mode)
