(setq auto-indent-on-save-file t)
(setq auto-indent-delete-trailing-whitespace-on-save-file t)
(setq auto-indent-untabify-on-save-file t)

(setq auto-indent-indent-style 'aggressive)

(require-package 'auto-indent-mode)
(auto-indent-global-mode)
