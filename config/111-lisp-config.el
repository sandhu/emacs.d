(global-prettify-symbols-mode +1)

(use-package paredit :ensure t
  :config (progn (defun conditionally-enable-paredit-mode ()
                   "Enable 'paredit-mode' in the minibuffer, during 'eval-expression'."
                   (if (eq this-command 'eval-expression)
                       (paredit-mode 1)))
                 (add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode))
  :bind (("C-M-<backspace>" . backward-kill-sexp)
         ("M-[" . paredit-wrap-square))
  :diminish "()")

(defun lisp-mode-setup ()
  (eldoc-mode)
  (paredit-mode +1)
  (whitespace-mode))

(add-hook 'lisp-mode-hook 'lisp-mode-setup)
(add-hook 'emacs-lisp-mode-hook 'lisp-mode-setup)

(use-package lisp-interaction-mode
  :config (paredit-mode +1))

(diminish-major-mode 'lisp-mode "λ")
(diminish-major-mode 'emacs-lisp-mode "ξλ")
(diminish-major-mode 'lisp-interaction-mode "λ»")
(diminish-major-mode 'slime-repl-mode "π»")

(use-package eldoc :diminish "")

(use-package elisp-slime-nav :ensure t
  :config (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
            (add-hook hook 'turn-on-elisp-slime-nav-mode))
  :diminish " π")
