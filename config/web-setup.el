(require-package 'web-mode)

(after 'web-mode-autoloads
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
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
              (setq web-mode-disable-auto-pairing nil)

              ;; automatically indent on RET
              (electric-indent-mode))))
