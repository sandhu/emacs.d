(require-package 'shell-pop)

(custom-set-variables
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell shell-pop-term-shell)))))
 '(shell-pop-universal-key "M-`")
 '(shell-pop-window-height 100)
 '(shell-pop-window-position "top"))
