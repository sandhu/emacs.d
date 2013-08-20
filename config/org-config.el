(require-package 'org)

(after 'org-autoloads
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-log-done t)
  (setq org-startup-indented t))

(provide 'org-config)
