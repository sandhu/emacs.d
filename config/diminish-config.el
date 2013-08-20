(require-package 'diminish)

(after 'diminish-autoloads
  (diminish 'auto-fill-function "")
  (after 'auto-indent-mode (diminish 'auto-indent-minor-mode ""))
  (after 'flyspell (diminish 'flyspell-mode " ~"))
  (after 'paredit (diminish 'paredit-mode " ()"))
  (after 'whitespace (diminish 'whitespace-mode ""))
  (after 'eldoc (diminish 'eldoc-mode ""))
  (after 'yasnippet (diminish 'yas-minor-mode " ys"))
  (after 'undo-tree (diminish 'undo-tree-mode " ut"))
  (after 'checkdoc (diminish 'checkdoc-minor-mode " cd"))
  (after 'git-gutter-mode (diminish 'git-gutter-mode ""))
  (after 'undo-tree-mode (diminish 'undo-tree-mode ""))

  (add-hook 'lisp-mode-hook (lambda () (setq mode-name "λ")))
  (add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name "ξλ")))
  (add-hook 'lisp-interaction-mode-hook (lambda () (setq mode-name "λ»")))
  (add-hook 'slime-repl-mode-hook (lambda () (setq mode-name "π»")))
  (after 'slime '(diminish 'slime-mode " π")) ; σ

  (add-hook 'clojure-mode-hook (lambda () (setq mode-name "Cλ")))
  (after 'clojure-test-mode (diminish 'clojure-test-mode ""))
  (after 'nrepl-interaction-mode (diminish 'nrepl-interaction-mode " η"))
  (after 'midje-mode (diminish 'midje-mode " Ɱ"))
;;  (add-hook 'hs-minor-mode-hook (diminish 'hs-minor-mode ""))
  (after 'kibit-mode (diminish 'kibit-mode " κ")))

;;(after 'diminish
;;(diminish 'undo-tree-mode)
;;  (diminish 'undo-tree-mode "")
;;  (add-hook 'undo-tree-visualizer-mode-hook
;;            (lambda () (setq mode-name "⅄"))))


(provide 'init-diminish)
