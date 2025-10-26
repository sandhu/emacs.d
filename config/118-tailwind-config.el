;; (use-package web-mode :ensure t
;;   :mode (("\\.html?\\'" . web-mode)
;;          ("\\.xml?\\'" . web-mode)
;;          ("\\.sgml?\\'" . web-mode))
;;   :config
;;   (setq web-mode-markup-indent-offset 2
;;         web-mode-css-indent-offset 2
;;         web-mode-code-indent-offset 2
;;         web-mode-indent-style 2
;;         web-mode-style-padding 1
;;         web-mode-script-padding 1
;;         web-mode-block-padding 0
;;         web-mode-enable-auto-pairing t
;;         web-mode-enable-css-colorization t)
;;   (electric-indent-mode)
;;   (diminish-major-mode 'web-mode "ω"))

;; ;; In html-mode, forward/backward-paragraph is infuriatingly slow
;; (defun skip-to-next-blank-line ()
;;   (interactive)
;;   (let ((inhibit-changing-match-data t))
;;     (skip-syntax-forward " >")
;;     (unless (search-forward-regexp "^\\s *$" nil t)
;;       (goto-char (point-max)))))

;; (defun skip-to-previous-blank-line ()
;;   (interactive)
;;   (let ((inhibit-changing-match-data t))
;;     (skip-syntax-backward " >")
;;     (unless (search-backward-regexp "^\\s *$" nil t)
;;       (goto-char (point-min)))))

;; brew install tailwindcss tailwindcss-language-server rustywind
(use-package lsp-tailwindcss :ensure t
  :after lsp-mode
  :init (setq lsp-tailwindcss-add-on-mode t
              lsp-tailwindcss-server-dir "/opt/homebrew/bin")
  :config
  (dolist (tw-major-mode
           '(clojurescript-mode
             css-mode
             css-ts-mode
             typescript-mode
             typescript-ts-mode
             tsx-ts-mode
             js2-mode
             js-ts-mode
             clojure-mode))
    (add-to-list 'lsp-tailwindcss-major-modes tw-major-mode))
  (add-hook 'before-save-hook 'lsp-tailwindcss-rustywind-before-save))


;; (use-package typescript-ts-mode
;;   :config
;;   (setq typescript-indent-level 2))
