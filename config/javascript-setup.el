(require-package 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; adds symbols included by google closure to js2-additional-externs
(add-hook 'js2-post-parse-callbacks
          (lambda ()
            (let ((buf (buffer-string))
                  (index 0))
              (while (string-match "\\(goog\\.require\\|goog\\.provide\\)('\\([^'.]*\\)" buf index)
                (setq index (+ 1 (match-end 0)))
                (add-to-list 'js2-additional-externs (match-string 2 buf))))))
