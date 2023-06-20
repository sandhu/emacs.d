(setq ns-use-srgb-colorspace nil)

;; Remove the UI
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))
(setq inhibit-startup-message t)
(set-fringe-mode '(1 . 1))
(setq use-dialog-box nil)

;; Setup the package management
(require 'package)
(setq package-enable-at-startup nil)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package exec-path-from-shell :ensure t
  :init (exec-path-from-shell-initialize))

;; Load the configuration
(let ((custom-file (expand-file-name "emacs-custom.el" user-emacs-directory))
      (user-config-file (expand-file-name (concat user-login-name ".el") user-emacs-directory)))
  (when (file-exists-p custom-file) (load custom-file))
  (dolist (dir (list "lisp" "config" user-login-name))
    (let ((config-dir (expand-file-name dir user-emacs-directory)))
      (when (file-exists-p config-dir)
        (add-to-list 'load-path config-dir)
        (mapc 'load (directory-files config-dir nil "^[^#].*el$")))))
  (when (file-exists-p user-config-file) (load user-config-file)))

;; Run the emacs server
(use-package server
  :if window-system
  :init (add-hook 'after-init-hook 'server-start t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(exec-path-from-shell dockerfile-mode docker yaml-mode markdown-mode es-mode js2-mode web-mode clj-refactor cider-eval-sexp-fu eval-sexp-fu cider clojure-mode-extra-font-locking clojure-mode flycheck-clj-kondo company-quickhelp company elisp-slime-nav paredit smartscan rainbow-delimiters magit aggressive-indent transpose-frame buffer-move ibuffer-vc flycheck-inline flycheck solarized-theme projectile wgrep-ag ag goto-chg lorem-ipsum multiple-cursors avy browse-kill-ring undo-tree expand-region smex flx-ido ido-completing-read+ beginend reveal-in-osx-finder diminish use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Menlo"))))
 '(eval-sexp-fu-flash ((t (:foreground "green4" :weight bold)))))
