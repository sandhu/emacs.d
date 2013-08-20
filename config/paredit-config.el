(require 'paredit)

(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round)
  (insert " ")
  (forward-char -1))

(defun paredit--is-at-start-of-sexp ()
  (and (looking-at "(\\|\\[")
       (not (nth 3 (syntax-ppss))) ;; inside string
       (not (nth 4 (syntax-ppss))))) ;; inside comment

(defun paredit-duplicate-closest-sexp ()
  (interactive)
  ;; skips to start of current sexp
  (while (not (paredit--is-at-start-of-sexp))
    (paredit-backward))
  (set-mark-command nil)
  ;; while we find sexps we move forward on the line
  (while (and (bounds-of-thing-at-point 'sexp)
              (<= (point) (car (bounds-of-thing-at-point 'sexp)))
              (not (= (point) (line-end-position))))
    (forward-sexp)
    (while (looking-at " ")
      (forward-char)))
  (kill-ring-save (mark) (point))
  ;; go to the next line and copy the sexprs we encountered
  (paredit-newline)
  (yank)
  (exchange-point-and-mark))

(defun setup-paredit-for-mode-map (mode-map)
  (define-key mode-map (kbd "s-<up>") 'paredit-raise-sexp)
  (define-key mode-map (kbd "s-<right>") 'paredit-forward-slurp-sexp)
  (define-key mode-map (kbd "s-<left>") 'paredit-forward-barf-sexp)
  (define-key mode-map (kbd "s-<backspace>") 'paredit-splice-sexp-killing-backward)
  (define-key mode-map (kbd "s-t") 'transpose-sexps)
  (define-key mode-map (kbd "M-(") 'paredit-wrap-round)
  (define-key mode-map (kbd "M-)") 'paredit-wrap-round-from-behind)
  (define-key mode-map (kbd "M-[") 'paredit-wrap-square)
  (define-key mode-map (kbd "C-M-d") 'paredit-duplicate-closest-sexp))

;; making paredit work with delete-selection-mode
;; (put 'paredit-forward-delete 'delete-selection 'supersede)
;; (put 'paredit-backward-delete 'delete-selection 'supersede)
;; (put 'paredit-open-round 'delete-selection t)
;; (put 'paredit-open-square 'delete-selection t)
;; (put 'paredit-doublequote 'delete-selection t)
;; (put 'paredit-newline 'delete-selection t)


;; Ensure that paredit is loaded for emacs-lisp
(after 'lisp-mode '(setup-paredit-for-mode-map emacs-lisp-mode-map))

;; Selectively enable paredit in the minibuffer
(defun conditionally-enable-paredit-mode ()
  "Enable 'paredit-mode' in the minibuffer, during 'eval-expression'."
  (if (eq this-command 'eval-expression)
      (paredit-mode 1)))

(add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode)
