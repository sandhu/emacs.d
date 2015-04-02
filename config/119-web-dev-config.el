(use-package web-mode :ensure t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.xml?\\'" . web-mode)
         ("\\.css?\\'" . web-mode))
  :config (progn (setq web-mode-markup-indent-offset 2
                       web-mode-css-indent-offset 2
                       web-mode-code-indent-offset 2
                       web-mode-indent-style 2
                       web-mode-style-padding 1
                       web-mode-script-padding 1
                       web-mode-block-padding 0
                       web-mode-enable-auto-pairing t
                       web-mode-enable-css-colorization t)
                 (electric-indent-mode)
                 (diminish-major-mode 'web-mode "ω")))

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

(use-package sgml-mode
  :bind (([remap forward-paragraph] . skip-to-next-blank-line)
         ([remap backward-paragraph] . skip-to-previous-blank-line)))
