(require-package 'diminish)

(defmacro diminish-major-mode (mode new-name)
  `(add-hook (intern (concat (symbol-name ,mode) "-hook"))
             '(lambda () (setq mode-name ,new-name))))

(after 'subword-mode (diminish 'subword-mode ""))

(diminish 'auto-fill-function "")
(after 'auto-indent-mode (diminish 'auto-indent-mode ""))
(after 'whitespace (diminish 'whitespace-mode ""))
(after 'flyspell (diminish 'flyspell-mode " ~"))

(after 'abbrev (diminish 'abbrev-mode " ⠤"))
(after 'hideshow (diminish 'hs-minor-mode ""))

(after 'paredit (diminish 'paredit-mode " ()"))

(after 'company (diminish 'company-mode  " α"))

(after 'undo-tree
  (diminish 'undo-tree-mode "")
  (diminish-major-mode 'undo-tree-visualizer-mode "⅄"))

(after 'projectile
  (diminish 'projectile-mode ""))

(after 'magit
  (diminish-major-mode 'magit-mode "Ɱ")
  (diminish 'magit-auto-revert-mode ""))

(diminish-major-mode 'lisp-mode "λ")
(diminish-major-mode 'emacs-lisp-mode "ξλ")
(diminish-major-mode 'lisp-interaction-mode "λ»")
(diminish-major-mode 'slime-repl-mode "π»")
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode " π"))
(after 'slime '(diminish 'slime-mode " π")) ; σ
(after 'eldoc (diminish 'eldoc-mode ""))

(diminish-major-mode 'clojure-mode "Cλ")
(after 'cider
  (diminish 'cider-mode " ç")
  (diminish-major-mode 'cider-repl-mode "Ç»")
  (after 'cider-macroexpansion
    (diminish 'cider-macroexpansion-minor-mode " Ɱ")))

(after 'clj-refactor (diminish 'clj-refactor-mode ""))

(after 'kibit-mode (diminish 'kibit-mode " κ"))

(after 'yasnippet (diminish 'yas-minor-mode " ʏ"))

(after 'git-gutter-mode (diminish 'git-gutter-mode ""))
(after 'git-gutter-fringe (diminish 'git-gutter-mode ""))

(after 'js2-mode (diminish-major-mode 'js2-mode "J"))
(after 'web-mode (diminish-major-mode 'web-mode "ω"))
