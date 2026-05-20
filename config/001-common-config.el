;; don't need right-to-left text
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

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

;; Tune the GC to kick in every 2MB instead of 0.76MB
(setq gc-cons-threshold 20000000)

(setq read-process-output-max (* 5 1024 1024))

(setopt isearch-lazy-count t)

(use-package diminish :ensure t)

(use-package saveplace :ensure t
  :init
  (advice-add 'save-place-find-file-hook :after
              (lambda (&rest _)
                (when buffer-file-name (ignore-errors (recenter)))))
  (save-place-mode 1)
  :custom
  ;; Change where the position data is stored
  (save-place-file "~/.emacs.d/places")
  ;; Increase the number of files remembered (default is 400)
  (save-place-limit 500))

(use-package savehist :ensure t
  :init
  (setq savehist-additional-variables
        '(search-ring regexp-search-ring kill-ring))
  (add-hook 'savehist-save-hook
            (lambda ()
              (setq kill-ring
                    (mapcar #'substring-no-properties
                            (cl-remove-if-not #'stringp kill-ring)))))
  (savehist-mode 1))

(desktop-save-mode 1)

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; save exiting copy buffer into the kill ring before overwriting
(setq save-interprogram-paste-before-kill t)

(setq kill-do-not-save-duplicates t)

(setq ffap-machine-p-known 'reject)

(setq help-window-select t)
