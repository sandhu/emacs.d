;;
;; clojure-mode
;;
(require-package 'clojure-mode)
(require-package 'cljsbuild-mode)

(require-package 'datomic-snippets)

(add-hook 'clojure-mode-hook
          (lambda ()
            (lisp-mode-setup)
            (setq buffer-save-without-query t)
            (push '("partial" . ?Ƥ) prettify-symbols-alist)
            (push '("comp" . ?ο) prettify-symbols-alist)
            (dolist (c (string-to-list ":_-?!#*"))
              (modify-syntax-entry c "w" clojure-mode-syntax-table))))

(setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode)
                                ("\\.cljx$" . clojure-mode)
                                ("\\.edn$" . clojure-mode)
                                ("\\.dtm$" . clojure-mode))
                              auto-mode-alist))

;;
;; cider
;;
(require-package 'cider)
(require-package 'cider-decompile)

(setq nrepl-hide-special-buffers nil)
(setq cider-repl-pop-to-buffer-on-connect nil)

(setq nrepl-log-messages t)
(setq cider-popup-stacktraces t)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)

(setq cider-repl-print-length 100)
(setq cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory))

(setq cider-repl-use-clojure-font-lock t)
(setq cider-switch-to-repl-command 'cider-switch-to-relevant-repl-buffer)

(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(add-to-list 'same-window-buffer-names "*cider*")
(add-hook 'cider-repl-mode-hook 'lisp-editing-setup)

(add-hook 'cider-connected-hook 'cider-enable-on-existing-clojure-buffers)

;; refactoring support
(require-package 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")))
(add-hook 'nrepl-connected-hook #'cljr-update-artifact-cache)

;; slamhound to rewrite ns forms
(require-package 'slamhound)

;;
;; dependency management
;;
(require-package 'latest-clojure-libraries)
