(require-package 'markdown-mode)
(require-package 'markdown-mode+)

(after 'markdown-mode-autoloads
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))
