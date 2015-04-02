(require 'uniquify)
(setq make-backup-files nil
      auto-save-default nil
      visible-bell t
      uniquify-buffer-name-style 'forward)

(global-hl-line-mode 1)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;; Tune the GC to kick in every 20MB instead of 0.76MB
(setq gc-cons-threshold 20000000)
