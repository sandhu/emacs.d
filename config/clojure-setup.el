;;
;; clojure-mode
;;
(require-package 'clojure-mode)
(require-package 'clojure-cheatsheet)
(require-package 'cljsbuild-mode)
(require-package 'typed-clojure-mode)

(require-package 'datomic-snippets)

(after 'clojure-mode-autoloads
  (add-hook 'clojure-mode-hook
            (lambda ()
              (lisp-mode-setup)
              (setq buffer-save-without-query t)
              (yas-minor-mode)))

  (defun replacement-region (replacement)
    (compose-region (match-beginning 1) (match-end 1) replacement))

  (font-lock-add-keywords
   'clojure-mode '(("(\\(fn\\)[\[[:space:]]" (0 (replacement-region "λ")))
                   ("\\(#\\)(" (0 (replacement-region "λ")))
                   ("(\\(partial\\)[[:space:]]" (0 (replacement-region "Ƥ")))
                   ("(\\(comp\\)[[:space:]]" (0 (replacement-region "ο")))))

  (setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode)
                                  ("\\.edn$" . clojure-mode)
                                  ("\\.dtm$" . clojure-mode))
                                auto-mode-alist))
  (after 'find-file-in-project
    (add-to-list 'ffip-patterns "*.clj")
    (add-to-list 'ffip-patterns "*.edn")
    (add-to-list 'ffip-patterns "*.dtm"))

  (defun core-logic-config ()
    "Update the indentation rules for core.logic"
    (put-clojure-indent 'run* 'defun)
    (put-clojure-indent 'fresh 'defun)
    (put-clojure-indent 'conde 'defun))
  (add-hook 'clojure-mode-hook 'core-logic-config)

  (defun toggle-clj-keyword-string ()
    "convert the string or keyword at (point) from string->keyword or keyword->string."
    (interactive)
    (let* ((original-point (point)))
      (while (and (> (point) 1)
                  (not (equal "\"" (buffer-substring-no-properties (point) (+ 1 (point)))))
                  (not (equal ":" (buffer-substring-no-properties (point) (+ 1 (point))))))
        (backward-char))
      (cond
       ((equal 1 (point))
        (message "beginning of file reached, this was probably a mistake."))
       ((equal "\"" (buffer-substring-no-properties (point) (+ 1 (point))))
        (insert ":" (substring (live-delete-and-extract-sexp) 1 -1)))
       ((equal ":" (buffer-substring-no-properties (point) (+ 1 (point))))
        (insert "\"" (substring (live-delete-and-extract-sexp) 1) "\"")))
      (goto-char original-point))))

;;
;; cider
;;
(require-package 'cider)
(require-package 'cider-decompile)
(require-package 'cider-tracing)

(after 'cider-autoloads
  (add-hook 'clojure-mode-hook 'cider-mode)
  (setq nrepl-hide-special-buffers t)
  (setq cider-repl-pop-to-buffer-on-connect nil)
  (setq cider-popup-stacktraces nil) ; will use nrepl-ritz for exceptions
  (setq cider-popup-stacktraces-in-repl t)
  (setq cider-auto-select-error-buffer t)
  (setq cider-repl-print-length 100)
  (setq cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory))
  (setq cider-repl-use-clojure-font-lock t)
  (setq cider-repl-print-length 100)
  (setq cider-switch-to-repl-command 'cider-switch-to-relevant-repl-buffer)

  (add-to-list 'same-window-buffer-names "*cider*")
  (add-hook 'cider-repl-mode-hook 'lisp-editing-setup)

  (require 'cider-macroexpansion)
  (add-hook 'cider-popup-buffer-mode-hook
            (lambda ()
              (if (member (buffer-name) (list cider-result-buffer
                                              cider-src-buffer
                                              cider-macroexpansion-buffer))
                  (clojure-mode))
              (setq mode-name "» Cλ")))

  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  (add-hook 'cider-connected-hook 'cider-enable-on-existing-clojure-buffers))

;;
;; Autocompletion for nrepl
;;
(require-package 'auto-complete)
(require-package 'ac-nrepl)

(after 'ac-nrepl-autoloads

  (after 'auto-complete
    (add-to-list 'ac-modes 'clojure-mode)
    (add-to-list 'ac-modes 'cider-repl-mode))

  (after 'cider-autoloads
    (defun set-auto-complete-as-completion-at-point-function ()
      (setq completion-at-point-functions '(auto-complete)))

    (add-hook 'cider-repl-mode-hook
              (lambda () (ac-nrepl-setup) (set-auto-complete-as-completion-at-point-function)))
    (add-hook 'cider-mode-hook
              (lambda () (ac-nrepl-setup) (set-auto-complete-as-completion-at-point-function)))))

;;
;; It only makes sense to run the following modes if we are editing a file
;;

;;
;; Midje mode
;;
(require-package 'midje-mode)
(require-package 'midje-test-mode)

(after 'midje-mode-autoloads
  (add-hook 'clojure-mode-hook
            (lambda () (if (buffer-file-name) (progn ;;(clojure-test-mode)
                                                (midje-mode))))))

;;
;; Kibit Mode
;;
(require-package 'kibit-mode)

(after 'kibit-mode-autoloads
  (add-hook 'clojure-mode-hook
            (lambda () (if (buffer-file-name) (progn (kibit-mode) (flymake-mode-on)))))

  ;; Teach compile the syntax of the kibit output
  (require 'compile)
  (add-to-list 'compilation-error-regexp-alist-alist
               '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
  (add-to-list 'compilation-error-regexp-alist 'kibit)

  ;; A convenient command to run "lein kibit" in the project to which
  ;; the current emacs buffer belongs to.
  (defun kibit ()
    "Run kibit on the current project. Display the results in a hyperlinked *compilation* buffer."
    (interactive)
    (compile "lein kibit")))
(after 'kibit-mode
  ;; kibit mode overrides C-c C-n, which is needed for evaluating namespace forms
  (define-key kibit-mode-keymap (kbd "C-c C-n") nil))

;;
;; dependency management
;;
(require-package 'latest-clojure-libraries)
