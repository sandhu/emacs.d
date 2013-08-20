;;
;; clojure-mode
;;
(require-package 'clojure-mode)
(require-package 'clojure-test-mode)
(require-package 'clojure-cheatsheet)

(after 'clojure-mode
  '(font-lock-add-keywords
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

  (defun core-logic-config ()
    "Update the indentation rules for core.logic"
    (put-clojure-indent 'run* 'defun)
    (put-clojure-indent 'fresh 'defun)
    (put-clojure-indent 'conde 'defun))

  (add-hook 'clojure-mode-hook
            (lambda ()
              (setq buffer-save-without-query t)
              (core-logic-config)))

  (defun char-at-point ()
    (interactive)
    (buffer-substring-no-properties (point) (+ 1 (point))))

  (defun clj-string-name (s)
    (substring s 1 -1))

  (defun clj-keyword-name (s)
    (substring s 1))

  (defun delete-and-extract-sexp ()
    (let* ((begin (point)))
      (forward-sexp)
      (let* ((result (buffer-substring-no-properties begin (point))))
        (delete-region begin (point))
        result)))

  (defun toggle-clj-keyword-string ()
    (interactive)
    (save-excursion
      (if (equal 1 (point))
          (message "beginning of file reached, this was probably a mistake.")
        (cond ((equal "\"" (char-at-point))
               (insert ":" (clj-string-name (delete-and-extract-sexp))))
              ((equal ":" (char-at-point))
               (insert "\"" (clj-keyword-name (delete-and-extract-sexp)) "\""))
              (t (progn
                   (backward-char)
                   (toggle-keyword-string)))))))
  (global-set-key (kbd "C-:") 'toggle-clj-keyword-string))

;;
;; nrepl
;;
(require-package 'nrepl)
(require-package 'nrepl-ritz)
(require-package 'nrepl-decompile)

(after 'nrepl

  (setq nrepl-hide-special-buffers t)
  (setq nrepl-popup-stacktraces nil) ; will use nrepl-ritz for exceptions
  (setq nrepl-history-file (concat user-emacs-directory "nrepl-history"))

  (add-to-list 'same-window-buffer-names "*nrepl*")
  (add-hook 'nrepl-mode-hook
            (lambda ()
              (paredit-mode +1)
              (show-paren-mode)
              (subword-mode)
              (setq mode-name "η")))
  (add-hook 'nrepl-connected-hook 'nrepl-enable-on-existing-clojure-buffers)

  (add-hook 'nrepl-interaction-mode-hook
            (lambda ()
              (nrepl-turn-on-eldoc-mode)
              (subword-mode)
              (diminish 'nrepl-interaction-mode " η")
              (require 'nrepl-ritz)))

  (define-key nrepl-mode-map (kbd "M-RET") 'nrepl-doc)
  (define-key nrepl-interaction-mode-map (kbd "M-RET") 'nrepl-doc)

  ;; specify the print length to be 100 to stop infinite sequences killing things.
  (defun live-nrepl-set-print-length ()
    (nrepl-send-string-sync "(set! *print-length* 100)" "clojure.core"))
  (add-hook 'nrepl-connected-hook 'live-nrepl-set-print-length)

  ;;(define-key nrepl-mode-map (kbd "C-c i") 'nrepl-inspect)

  ;; Ritz middleware
  ;;(define-key nrepl-interaction-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
  ;;(define-key nrepl-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
  ;;(define-key nrepl-interaction-mode-map (kbd "C-c C-a") 'nrepl-apropos)
  ;;(define-key nrepl-mode-map (kbd "C-c C-a") 'nrepl-apropos)

  )

;;
;; Autocompletion for nrepl
;;
(require-package 'ac-nrepl)

(after 'ac-nrepl-autoloads
  (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
  (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)

  (after 'auto-complete-autoloads
    '(add-to-list 'ac-modes 'nrepl-mode))

  ;; ;; autocomplete via TAB
  ;; (defun set-auto-complete-as-completion-at-point-function ()
  ;;   (setq completion-at-point-functions '(auto-complete)))
  ;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

  ;; (add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
  ;; (add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

  (after 'nrepl
    (define-key nrepl-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)
    (define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)))

;;
;; Midje mode
;;
(require-package 'midje-mode)
(require 'diminish)

(after 'clojure-autoloads
  (add-hook 'clojure-mode-hook
            (lambda ()
              (clojure-test-mode)
              (midje-mode))))

;;
;; Kibit Mode
;;
(require-package 'kibit-mode)
(after 'kibit-mode
  (add-hook 'clojure-mode-hook
            (lambda ()
              (kibit-mode)
              (flymake-mode)))

  ;; kibit mode overrides C-c C-n, which is needed for evaluating namespace forms
  (define-key kibit-mode-keymap (kbd "C-c C-n") nil)

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
    (compile "lein kibit"))

  (add-hook 'clojure-mode-hook
            (lambda ()
              (flymake-mode-on)
              (flymake-cursor-mode))))
