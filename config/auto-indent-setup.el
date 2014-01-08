(require-package 'auto-indent-mode)

(after 'auto-indent-mode-autoloads
  (setq auto-indent-mode-untabify-on-yank-or-paste t)
  (setq auto-indent-delete-trailing-whitespace-on-save-file t)
  (setq auto-indent-untabify-on-save-file t)
  (setq auto-indent-on-save-file t)
  ;;  (setq auto-indent-indent-style 'conservative)
  (auto-indent-global-mode))
