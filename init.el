(setq ns-use-srgb-colorspace nil)

;; Remove the UI
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))
(setq inhibit-startup-message t)
(set-fringe-mode '(1 . 1))
(setq use-dialog-box nil)

;; Make sure path is correct when launched as application
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

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

;; Load the configuration
(let ((custom-file (expand-file-name "emacs-custom.el" user-emacs-directory)))
  (progn
    (when (file-exists-p custom-file) (load custom-file))
    (dolist (dir (list "lisp" "config" user-login-name))
      (let ((config-dir (expand-file-name dir user-emacs-directory)))
        (when (file-exists-p config-dir)
          (add-to-list 'load-path config-dir)
          (mapc 'load (directory-files config-dir nil "^[^#].*el$")))))))

;; Run the emacs server
(use-package server
  :if window-system
  :init (add-hook 'after-init-hook 'server-start t))
