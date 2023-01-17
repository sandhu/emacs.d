(global-prettify-symbols-mode +1)
(global-eldoc-mode 1)
(eldoc-mode 1)

(defun conditionally-enable-paredit-mode ()
  "Enable 'paredit-mode' in the minibuffer, during 'eval-expression'."
  (if (eq this-command 'eval-expression)
      (paredit-mode 1)))

(use-package paredit :ensure t
  :config (progn
            (add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode)
            (unbind-key (kbd "RET") paredit-mode-map))
  :bind (("C-M-<backspace>" . backward-kill-sexp)
         ("M-[" . paredit-wrap-square))
  :diminish "()")

(defun lisp-mode-setup ()
  (paredit-mode +1)
  (whitespace-mode))

(add-hook 'lisp-mode-hook 'lisp-mode-setup)
(add-hook 'emacs-lisp-mode-hook 'lisp-mode-setup)

(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (paredit-mode +1)
            (diminish-major-mode 'lisp-interaction-mode "λ»")))

(diminish-major-mode 'lisp-mode "λ")
(diminish-major-mode 'emacs-lisp-mode "ξλ")
(diminish-major-mode 'slime-repl-mode "π»")

(use-package elisp-slime-nav :ensure t
  :config (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
            (add-hook hook 'turn-on-elisp-slime-nav-mode))
  :diminish " π")
