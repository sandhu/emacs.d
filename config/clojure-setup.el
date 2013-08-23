;;
;; clojure-mode
;;
(require-package 'clojure-mode)
(require-package 'clojure-test-mode)
(require-package 'clojure-cheatsheet)

(after 'clojure-mode-autoloads
  (add-hook 'clojure-mode-hook
            (lambda ()
              (lisp-mode-setup)
              (setq buffer-save-without-query t)))

  (font-lock-add-keywords
   'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "λ")
                              nil)))
                   ("\\(#\\)("
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "λ") ; "ƒ"
                              nil)))
                   ("(\\(partial\\)[[:space:]]"
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "Ƥ")
                              nil)))
                   ("(\\(comp\\)[[:space:]]"
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "ο")
                              nil)))))

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
;; nrepl
;;
(require-package 'nrepl)
(require-package 'nrepl-ritz)
(require-package 'nrepl-decompile)

(after 'nrepl-autoloads
  (add-hook 'clojure-mode-hook 'nrepl-interaction-mode)
  (setq nrepl-hide-special-buffers t)
  (setq nrepl-popup-stacktraces nil) ; will use nrepl-ritz for exceptions
  (setq nrepl-popup-stacktraces-in-repl nil)
  (setq nrepl-history-file (expand-file-name "nrepl-history" user-emacs-directory))

  (add-to-list 'same-window-buffer-names "*nrepl*")
  (add-hook 'nrepl-mode-hook
            (lambda ()
              (lisp-mode-setup)
              (setq mode-name "η")))
  (add-hook 'nrepl-connected-hook 'nrepl-enable-on-existing-clojure-buffers)

  (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)

  ;; specify the print length to be 100 to stop infinite sequences killing things.
  (defun live-nrepl-set-print-length ()
    (nrepl-send-string-sync "(set! *print-length* 100)" "clojure.core"))
  (add-hook 'nrepl-connected-hook 'live-nrepl-set-print-length))

;;
;; Autocompletion for nrepl
;;
(require-package 'auto-complete)
(require-package 'ac-nrepl)

(after 'ac-nrepl-autoloads

  (after 'auto-complete
    (add-to-list 'ac-modes 'clojure-mode)
    (add-to-list 'ac-modes 'nrepl-mode))

  (after 'nrepl-autoloads
    (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
    (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)

    (defun set-auto-complete-as-completion-at-point-function ()
      (setq completion-at-point-functions '(auto-complete)))
    (add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
    (add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)
    (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)))

;;
;; Midje mode
;;
(require-package 'midje-mode)

(after 'midje-mode-autoloads
  (add-hook 'clojure-mode-hook
            (lambda ()
              (clojure-test-mode)
              (midje-mode))))

;;
;; Kibit Mode
;;
(require-package 'kibit-mode)

(after 'kibit-mode-autoloads
  (add-hook 'clojure-mode-hook
            (lambda ()
              (kibit-mode)
              (flymake-mode-on)))

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

;; latest clojars
(require-package 'latest-clojars)
