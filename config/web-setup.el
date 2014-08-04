(require-package 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))

(add-hook 'web-mode-hook
          (lambda ()
            ;; setup indentation
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            (setq web-mode-indent-style 2)
            (setq web-mode-style-padding 1)
            (setq web-mode-script-padding 1)
            (setq web-mode-block-padding 0)

            ;; enable auto-pairing
            (setq web-mode-enable-auto-pairing t)

            (setq web-mode-enable-css-colorization t)

            ;; automatically indent on RET
            (electric-indent-mode)))

;; In html-mode, forward/backward-paragraph is infuriatingly slow
(defun skip-to-next-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (skip-syntax-forward " >")
    (unless (search-forward-regexp "^\\s *$" nil t)
      (goto-char (point-max)))))

(defun skip-to-previous-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (skip-syntax-backward " >")
    (unless (search-backward-regexp "^\\s *$" nil t)
      (goto-char (point-min)))))

(after 'sgml-mode
  (define-key html-mode-map [remap forward-paragraph] 'skip-to-next-blank-line)
  (define-key html-mode-map [remap backward-paragraph] 'skip-to-previous-blank-line))
