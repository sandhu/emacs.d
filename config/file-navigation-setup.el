(require-package 'ag)
(require-package 'wgrep-ag)
(require-package 'find-file-in-project)
(require-package 'projectile)
(require-package 'reveal-in-finder)

(after 'ag-autoloads
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers t)
  (setq ag-reuse-windows t))

(after 'projectile-autoloads
  (projectile-global-mode))
