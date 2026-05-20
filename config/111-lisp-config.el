(global-prettify-symbols-mode +1)
(global-eldoc-mode 1)
(eldoc-mode 1)

(defun conditionally-enable-paredit-mode ()
  "Enable 'paredit-mode' in the minibuffer, during 'eval-expression'."
  (if (eq this-command 'eval-expression)
      (paredit-mode 1)))

(use-package paredit :ensure t
  :config
  (add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode)
  (unbind-key (kbd "RET") paredit-mode-map)
  :bind
  (("C-M-<backspace>" . backward-kill-sexp)
   ("M-[" . paredit-wrap-square))
  :diminish "()")

(defun lisp-mode-setup ()
  (paredit-mode +1)
  (whitespace-mode))

(add-hook 'lisp-mode-hook 'lisp-mode-setup)
(add-hook 'emacs-lisp-mode-hook 'lisp-mode-setup)
(add-hook 'lisp-interaction-mode-hook 'lisp-mode-setup)
