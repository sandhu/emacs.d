(use-package clojure-mode :ensure t
  :pin melpa-stable
  :init (progn
          (setq buffer-save-without-query t)
          (add-hook 'clojure-mode-hook (lambda ()
                                         (push '("partial" . ?Ƥ) prettify-symbols-alist)
                                         (push '("comp" . ?ο) prettify-symbols-alist)
                                         (lisp-mode-setup))))
  :mode (("\\.cljs$" . clojure-mode)
         ("\\.cljx$" . clojure-mode)
         ("\\.edn$" . clojure-mode)
         ("\\.dtm$" . clojure-mode))
  :config (diminish-major-mode 'clojure-mode "Cλ")
  :bind-keymap ("C-c C-z" . nil))

(use-package cider :ensure t
  :pin melpa-stable
  :init (progn
          (setq nrepl-hide-special-buffers nil
                cider-repl-pop-to-buffer-on-connect nil
                cider-prompt-for-symbol nil
                nrepl-log-messages t
                cider-popup-stacktraces t
                cider-repl-popup-stacktraces t
                cider-auto-select-error-buffer t
                cider-repl-print-length 100
                cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory)
                cider-repl-use-clojure-font-lock t
                cider-switch-to-repl-command 'cider-switch-to-relevant-repl-buffer)
          (add-hook 'clojure-mode-hook 'cider-mode))
  :config (progn
            (diminish-major-mode 'cider-repl-mode "Ç»")
            (cider-turn-on-eldoc-mode)
            (add-to-list 'same-window-buffer-names "*cider*")
            (add-hook 'cider-repl-mode-hook 'lisp-mode-setup)
            (add-hook 'cider-connected-hook 'cider-enable-on-existing-clojure-buffers))
  :diminish " ç") ; Remove the binding for inferior-lisp-mode

(use-package eval-sexp-fu :ensure t
  :init (custom-set-faces '(eval-sexp-fu-flash ((t (:foreground "green4" :weight bold))))))

(use-package cider-eval-sexp-fu :ensure t)

(use-package clj-refactor :ensure t
  :init (add-hook 'clojure-mode-hook (lambda ()
                                       (clj-refactor-mode 1)
                                       (cljr-add-keybindings-with-prefix "C-c C-m")))
  :config (add-hook 'nrepl-connected-hook #'cljr-update-artifact-cache)
  :diminish "")

(use-package cljsbuild-mode :ensure t)

(use-package datomic-snippets :ensure t)

(use-package slamhound :ensure t)

(use-package latest-clojure-libraries :ensure t)
