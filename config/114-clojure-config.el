(use-package clojure-ts-mode :ensure t
  :init
  (setq buffer-save-without-query t)
  (setopt clojure-ts-completion-enabled nil)
  (setopt clojure-ts-indent-style 'fixed)
  (setopt clojure-ts-extra-def-forms '("defnc"))
  (setopt clojure-ts-toplevel-inside-comment-form t)
  (push '(">fn" . (?> (Br . Bl) ?λ)) prettify-symbols-alist)
  (push '("partial" . ?Ƥ) prettify-symbols-alist)
  (push '("comp" . ?ο) prettify-symbols-alist)
  :hook
  (clojure-ts-mode . lisp-mode-setup)
  (clojure-ts-mode . cider-mode)
  (before-save . lsp-clojure-clean-ns)
  :diminish "Cλ")

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
  (add-hook 'cider-repl-mode-hook
            (lambda ()
              (lisp-mode-setup)
              (aggressive-indent-mode 0)))
  (cider-enable-cider-completion-style)
  :diminish " ç")

(use-package clj-refactor :ensure t)

(use-package eval-sexp-fu :ensure t
  :init (custom-set-faces '(eval-sexp-fu-flash ((t (:foreground "green4" :weight bold))))))

(use-package cider-eval-sexp-fu :ensure t)

(use-package lsp-mode :ensure t
  :hook ((clojure-ts-mode . lsp)
         (clojurec-ts-mode . lsp)
         (clojurescript-ts-mode . lsp))
  :config
  (dolist (m '(clojure-mode
               clojure-ts-mode
               clojurec-mode
               clojurescript-mode
               clojure-ts-clojurescript-mode
               clojurex-mode))
    (add-to-list 'lsp-language-id-configuration `(,m . "clojure"))))
