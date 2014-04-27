;; Turn on the maxium syntax highlighting
(setq font-lock-maximum-decoration t)

(require-package 'rainbow-delimiters)
(require-package 'smartscan)

(defun add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook
          (lambda ()
            (add-watchwords)
            (flyspell-prog-mode)
            (rainbow-delimiters-mode)
            (smartscan-mode)))
