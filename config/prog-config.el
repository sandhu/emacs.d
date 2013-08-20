;; Turn on the maxium syntax highlighting
(setq font-lock-maximum-decoration t)

(defun add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook
          (lambda ()
            (add-watchwords)
            (flyspell-prog-mode)
            (rainbow-delimiters-mode)
            (global-set-key (kbd "M-/") 'comment-or-uncomment-region)))

(add-hook 'before-save-hook 'cleanup-buffer)

(provide 'init-prog)
