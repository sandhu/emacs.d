(defun add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(use-package prog-mode
  :init (setq font-lock-maximum-decoration t)
  :bind ("M-/" . comment-or-uncomment-region)
  :config (progn
            (show-paren-mode)
            (add-watchwords)))

(use-package rainbow-delimiters :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package smartscan :ensure t
  :init (add-hook 'prog-mode-hook 'smartscan-mode)
  :config (setq smartscan-symbol-selector "symbol"))

(use-package subword
  :init (add-hook 'prog-mode-hook 'subword-mode)
  :diminish "")
