(require-package 'elisp-slime-nav)

(after 'elisp-slime-nav-autoloads
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'turn-on-elisp-slime-nav-mode)))
