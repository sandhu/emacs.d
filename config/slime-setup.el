(let ((slh (expand-file-name "~/quicklisp/slime-helper.el"))
      (clhs (expand-file-name "~/quicklisp/clhs-use-local.el")))

  (when (and (file-exists-p slh) (file-exists-p clhs))
    (load slh)
    (load clhs)

    (setq slime-net-coding-system 'utf-8-unix)
    (setq slime-compile-file-options '(:fasl-directory "~/.Trash/"))
    (setq inferior-lisp-program "/usr/local/bin/ccl64"
          lisp-indent-function 'common-lisp-indent-function
          slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
    (slime-setup '(slime-fancy))
    ;; Stop SLIME's REPL from grabbing DEL,
    ;; which is annoying when backspacing over a '('
    (defun override-slime-repl-bindings-with-paredit ()
      (define-key slime-repl-mode-map
        (read-kbd-macro paredit-backward-delete-key) nil))
    (add-hook 'slime-repl-mode-hook (lambda ()
                                      (lisp-editing-setup)
                                      (override-slime-repl-bindings-with-paredit)))
    (add-hook 'lisp-mode-hook 'slime-mode)

    (after 'slime
      (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol
            slime-fuzzy-completion-in-place t
            slime-enable-evaluate-in-emacs t
            slime-autodoc-use-multiline-p t)

      (define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
      (define-key slime-mode-map (kbd "C-c i") 'slime-inspect)
      (define-key slime-mode-map (kbd "C-c C-s") 'slime-selector)
      (define-key slime-mode-map (kbd "C-t") 'transpose-sexps)
      (define-key slime-mode-map (kbd "C-M-t") 'transpose-chars)
      (define-key slime-mode-map (kbd "C-b") 'backward-sexp)
      (define-key slime-mode-map (kbd "C-M-b") 'backward-char)
      (define-key slime-mode-map (kbd "C-f") 'forward-sexp)
      (define-key slime-mode-map (kbd "C-M-f") 'forward-char))

    (add-hook 'inferior-lisp-mode-hook 'inferior-slime-mode)

    ;; Show documentation/information with M-RET
    (defun live-lisp-describe-thing-at-point ()
      "Show the documentation of the Elisp function and variable near point.
   This checks in turn:
     -- for a function name where point is
     -- for a variable name where point is
     -- for a surrounding function call"
      (interactive)
      (let (sym)
        ;; sigh, function-at-point is too clever.  we want only the first half.
        (cond ((setq sym (ignore-errors
                           (with-syntax-table emacs-lisp-mode-syntax-table
                             (save-excursion
                               (or (not (zerop (skip-syntax-backward "_w")))
                                   (eq (char-syntax (char-after (point))) ?w)
                                   (eq (char-syntax (char-after (point))) ?_)
                                   (forward-sexp -1))
                               (skip-chars-forward "`'")
                               (let ((obj (read (current-buffer))))
                                 (and (symbolp obj) (fboundp obj) obj))))))
               (describe-function sym))
              ((setq sym (variable-at-point)) (describe-variable sym)))))
    (define-key lisp-mode-shared-map (kbd "M-RET") 'live-lisp-describe-thing-at-point)))
