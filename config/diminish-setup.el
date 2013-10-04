(require-package 'diminish)

(defmacro diminish-major-mode (mode new-name)
  `(add-hook (intern (concat (symbol-name ,mode) "-hook"))
             '(lambda () (setq mode-name ,new-name))))

(after 'diminish-autoloads
  (diminish 'auto-fill-function "")
  (after 'auto-indent-mode (diminish 'auto-indent-mode ""))
  (after 'whitespace (diminish 'whitespace-mode ""))
  (after 'flyspell (diminish 'flyspell-mode " ~"))

  (after 'abbrev (diminish 'abbrev-mode " ⠤"))
  (after 'hideshow (diminish 'hs-minor-mode ""))

  (after 'paredit (diminish 'paredit-mode " ()"))

  (after 'auto-complete (diminish 'auto-complete-mode  " α"))

  (after 'undo-tree
    (diminish 'undo-tree-mode "")
    (diminish-major-mode 'undo-tree-visualizer-mode "⅄"))

  (diminish-major-mode 'lisp-mode "λ")
  (diminish-major-mode 'emacs-lisp-mode "ξλ")
  (diminish-major-mode 'lisp-interaction-mode "λ»")
  (diminish-major-mode 'slime-repl-mode "π»")
  (after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode " π"))
  (after 'slime '(diminish 'slime-mode " π")) ; σ
  (after 'eldoc (diminish 'eldoc-mode ""))

  (diminish-major-mode 'clojure-mode "Cλ")
  (after 'clojure-test-mode (diminish 'clojure-test-mode ""))
  (after 'nrepl
    (diminish 'nrepl-interaction-mode " η")
    (diminish-major-mode 'nrepl-repl-mode "η»")
    (diminish 'nrepl-macroexpansion-minor-mode " Ɱ"))
  (after 'midje-mode (diminish 'midje-mode " Ƭ"))

  (after 'kibit-mode (diminish 'kibit-mode " κ"))

  (after 'yasnippet (diminish 'yas-minor-mode " ʏ"))

  (after 'git-gutter-mode (diminish 'git-gutter-mode ""))
  (after 'git-gutter-fringe (diminish 'git-gutter-mode ""))

  (after 'js2-mode (diminish-major-mode 'js2-mode "J"))
  (after 'web-mode (diminish-major-mode 'web-mode "ω")))
