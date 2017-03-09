(use-package clojure-mode :ensure t
  :init (progn
          (setq buffer-save-without-query t)
          (add-hook 'clojure-mode-hook
                    (lambda ()
                      (push '("partial" . ?Ƥ) prettify-symbols-alist)
                      (push '("comp" . ?ο) prettify-symbols-alist)
                      (lisp-mode-setup))))
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
                cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory)
                cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))"))
  :config (progn
            (diminish-major-mode 'cider-repl-mode "Ç»")
            (add-to-list 'same-window-buffer-names "*cider*")
            (add-hook 'cider-repl-mode-hook 'lisp-mode-setup))
  :diminish " ç")

(use-package eval-sexp-fu :ensure t
  :init (custom-set-faces '(eval-sexp-fu-flash ((t (:foreground "green4" :weight bold))))))

(use-package cider-eval-sexp-fu :ensure t)

(use-package clj-refactor :ensure t
  :init (add-hook 'clojure-mode-hook (lambda ()
                                       (clj-refactor-mode 1)
                                       (cljr-add-keybindings-with-prefix "C-c M-r")))
  :diminish "")

(use-package cljsbuild-mode :ensure t)
