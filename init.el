;; Remove the UI
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))
(setq inhibit-startup-message t)

;; Make sure path is correct when launched as application
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; Add the top level emacs config directory to the load path
(add-to-list 'load-path user-emacs-directory)

;; Setup the package management
(require 'init-packages)

;; Install the essential packages
(require 'init-essential)

;; Load the configuration
(let ((custom-file (expand-file-name "emacs-custom.el" user-emacs-directory))
      (defuns-dir (expand-file-name "defuns" user-emacs-directory))
      (config-dir (expand-file-name "config" user-emacs-directory)))
  (progn
    (when (file-exists-p custom-file) (load custom-file))
    (when (file-exists-p defuns-dir)
      (add-to-list 'load-path defuns-dir)
      (mapc 'load (directory-files defuns-dir nil "^[^#].*el$")))
    (when (file-exists-p config-dir)
      (add-to-list 'load-path config-dir)
      (mapc 'load (directory-files config-dir nil "^[^#].*el$")))))

;; Run the emacs server
(require 'server)
(unless (server-running-p) (server-start))
