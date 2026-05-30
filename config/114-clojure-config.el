(use-package clojure-ts-mode :ensure t
  :init
  (setq buffer-save-without-query t)
  (setopt clojure-ts-completion-enabled nil)
  (setopt clojure-ts-indent-style 'fixed)
  (setopt clojure-ts-extra-def-forms '("defnc"))
  (setopt clojure-ts-toplevel-inside-comment-form t)
  :hook
  ((clojure-ts-mode
    . (lambda ()
        (setq-local prettify-symbols-alist
                    '(("fn" . ?λ)
                      ("#"  . ?λ)
                      ("partial" . ?Ƥ)
                      ("comp" . ?ο)
                      (">fn" . (?> (Br . Bl) ?λ))))
        (lisp-mode-setup)
        (cider-mode)))
   (before-save
    . (lambda ()
        (whitespace-cleanup)
        (lsp-clojure-clean-ns)
        (lsp-format-buffer))))
  :diminish "Cλ")
;; If (lsp-clojure-clean-ns) is hanging, make sure semgrep-lsp is not running
;; clojure-ts-reinstall-grammars

(use-package clojure-mode :ensure t)
(use-package cider :ensure t
  :init
  (setq nrepl-hide-special-buffers nil
        cider-repl-pop-to-buffer-on-connect nil
        cider-prompt-for-symbol nil
        cider-overlays-use-font-lock t
        nrepl-log-messages t
        cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory))
  :config
  (add-to-list 'same-window-buffer-names "*cider*")
  (cider-enable-cider-completion-style)
  :hook
  ((cider-repl-mode
    . (lambda ()
        (lisp-mode-setup)
        (aggressive-indent-mode 0))))
  :diminish " ç")

(use-package eval-sexp-fu :ensure t
  :init (custom-set-faces '(eval-sexp-fu-flash ((t (:foreground "green4" :weight bold))))))

(use-package cider-eval-sexp-fu :ensure t)

(use-package lsp-mode :ensure t
  :hook ((clojure-ts-mode clojurescript-ts-mode clojurec-ts-mode) . lsp)
  :config
  (dolist (m '(clojure-ts-mode
               clojure-mode
               clojure-ts-clojurec-mode
               clojurec-mode
               clojure-ts-clojurescript-mode
               clojurescript-mode
               clojurex-mode))
    (add-to-list 'lsp-language-id-configuration `(,m . "clojure"))))
