(use-package js2-mode :ensure t
  :mode "\\.js$"
  :config (progn
            (add-hook 'js2-post-parse-callbacks
                      ;; adds symbols included by google closure to js2-additional-externs
                      (lambda ()
                        (let ((buf (buffer-string))
                              (index 0))
                          (while (string-match "\\(goog\\.require\\|goog\\.provide\\)('\\([^'.]*\\)" buf index)
                            (setq index (+ 1 (match-end 0)))
                            (add-to-list 'js2-additional-externs (match-string 2 buf))))))
            (diminish-major-mode 'js2-mode "J")))
