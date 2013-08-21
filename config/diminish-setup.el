(require-package 'diminish)

(after 'diminish-autoloads
  (diminish 'auto-fill-function "")
  (after 'auto-indent-mode (diminish 'auto-indent-minor-mode ""))
  (after 'whitespace (diminish 'whitespace-mode ""))
  (after 'flyspell (diminish 'flyspell-mode " ~"))

  (after 'abbrev (diminish 'abbrev-mode " ⠤"))
  (after 'paredit (diminish 'paredit-mode " ()"))
  (after 'auto-complete (diminish 'auto-complete-mode  " α"))

  (add-hook 'lisp-mode-hook (lambda () (setq mode-name "λ")))
  (add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name "ξλ")))
  (add-hook 'lisp-interaction-mode-hook (lambda () (setq mode-name "λ»")))
  (add-hook 'slime-repl-mode-hook (lambda () (setq mode-name "π»")))
  (after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode " π"))
  (after 'slime '(diminish 'slime-mode " π")) ; σ
  (after 'eldoc (diminish 'eldoc-mode ""))

  (add-hook 'clojure-mode-hook (lambda () (setq mode-name "Cλ")))
  (after 'clojure-test-mode (diminish 'clojure-test-mode ""))
  (after 'nrepl (diminish 'nrepl-interaction-mode " η"))
  (after 'midje-mode (diminish 'midje-mode " Ɱ"))
  ;;  (add-hook 'hs-minor-mode-hook (diminish 'hs-minor-mode ""))
  (after 'kibit-mode (diminish 'kibit-mode " κ"))

  (after 'git-gutter-mode (diminish 'git-gutter-mode ""))
  (after 'git-gutter-fringe (diminish 'git-gutter-mode "")))

;;(after 'diminish
;;(diminish 'undo-tree-mode)
;;  (diminish 'undo-tree-mode "")
;;  (add-hook 'undo-tree-visualizer-mode-hook
;;            (lambda () (setq mode-name "⅄"))))
