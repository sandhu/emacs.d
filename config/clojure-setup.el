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
            (dolist (c (string-to-list ":_-?!#*"))
              (modify-syntax-entry c "w" clojure-mode-syntax-table))))

(defun replacement-region (replacement)
  (compose-region (match-beginning 1) (match-end 1) replacement))

(font-lock-add-keywords
 'clojure-mode '(("(\\(fn\\)[\[[:space:]]" (0 (replacement-region "λ")))
                 ("\\(#\\)(" (0 (replacement-region "λ")))
                 ("(\\(partial\\)[[:space:]]" (0 (replacement-region "Ƥ")))
                 ("(\\(comp\\)[[:space:]]" (0 (replacement-region "ο")))))

(setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode)
                                ("\\.cljx$" . clojure-mode)
                                ("\\.edn$" . clojure-mode)
                                ("\\.dtm$" . clojure-mode))
                              auto-mode-alist))

(defun core-logic-config ()
  "Update the indentation rules for core.logic"
  (put-clojure-indent 'run* 'defun)
  (put-clojure-indent 'fresh 'defun)
  (put-clojure-indent 'conde 'defun))
(add-hook 'clojure-mode-hook 'core-logic-config)

;;
;; cider
;;
(require-package 'cider)
(require-package 'cider-decompile)
(require-package 'cider-browse-ns)

(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(setq nrepl-hide-special-buffers nil)
(setq cider-repl-pop-to-buffer-on-connect nil)

(setq cider-popup-stacktraces t)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)

(setq cider-repl-print-length 100)
(setq cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory))

(setq cider-repl-use-clojure-font-lock t)
(setq cider-switch-to-repl-command 'cider-switch-to-relevant-repl-buffer)

(add-to-list 'same-window-buffer-names "*cider*")
(add-hook 'cider-repl-mode-hook 'lisp-editing-setup)

(add-hook 'cider-connected-hook 'cider-enable-on-existing-clojure-buffers)

;; slamhound to rewrite ns forms
(require-package 'slamhound)

;;
;; Kibit Mode
;;
;; (require-package 'kibit-mode)

;; (add-hook 'clojure-mode-hook
;;           (lambda () (when (buffer-file-name) (progn (kibit-mode) (flymake-mode-on)))))

;; Teach compile the syntax of the kibit output
;; (require 'compile)
;; (add-to-list 'compilation-error-regexp-alist-alist
;;              '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
;; (add-to-list 'compilation-error-regexp-alist 'kibit)

;; A convenient command to run "lein kibit" in the project to which
;; the current emacs buffer belongs to.
;; (defun kibit ()
;;   "Run kibit on the current project. Display the results in a hyperlinked *compilation* buffer."
;;   (interactive)
;;   (compile "lein kibit"))

;; (after 'kibit-mode
;;   ;; kibit mode overrides C-c C-n, which is needed for evaluating namespace forms
;;   (define-key kibit-mode-keymap (kbd "C-c C-n") nil))

;;
;; dependency management
;;
(require-package 'latest-clojure-libraries)
