(use-package clojure-mode :ensure t
  :init (progn
          (setq buffer-save-without-query t)
          (add-hook 'clojure-mode-hook
                    (lambda ()
                      (lisp-mode-setup)
                      (put-clojure-indent 'async 1)
                      (put-clojure-indent 'checking 1)
                      (put-clojure-indent 'then :defn)
                      (put-clojure-indent 'catch :defn)
                      (put-clojure-indent '>fn :defn)
                      (put-clojure-indent '>λ :defn)
                      (put-clojure-indent 'deftask :defn)
                      (put-clojure-indent '>defn :defn)
                      (put-clojure-indent '>defn- :defn)
                      (push '(">fn" . (?> (Br . Bl) ?λ)) prettify-symbols-alist)
                      (push '("partial" . ?Ƥ) prettify-symbols-alist)
                      (push '("comp" . ?ο) prettify-symbols-alist))))
  :config (progn
            (diminish-major-mode 'clojure-mode "Cλ")
            (bind-key "C-c C-z" nil clojure-mode-map))) ; Remove the binding for inferior-lisp-mode

(use-package clojure-mode-extra-font-locking :ensure t)

(use-package cider :ensure t
  :init (progn
          (setq nrepl-hide-special-buffers nil
                cider-repl-pop-to-buffer-on-connect nil
                cider-prompt-for-symbol nil
                cider-overlays-use-font-lock t
                nrepl-log-messages t
                cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory)))
  :config (progn
            (diminish-major-mode 'cider-repl-mode "Ç»")
            (add-to-list 'same-window-buffer-names "*cider*")
            (add-hook 'cider-repl-mode-hook
                      (lambda ()
                        (lisp-mode-setup)
                        (aggressive-indent-mode 0)))
            (cider-enable-cider-completion-style))
  :diminish " ç")

(use-package eval-sexp-fu :ensure t
  :init (custom-set-faces '(eval-sexp-fu-flash ((t (:foreground "green4" :weight bold))))))

(use-package cider-eval-sexp-fu :ensure t)

(use-package lsp-mode :ensure t
  :hook ((clojure-mode . lsp)
         (clojurec-mode . lsp)
         (clojurescript-mode . lsp))
  :config
  (progn
    (dolist (m '(clojure-mode
                 clojurec-mode
                 clojurescript-mode
                 clojurex-mode))
      (add-to-list 'lsp-language-id-configuration `(,m . "clojure")))))
