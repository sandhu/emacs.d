(require-package 'color-theme-solarized)

(after 'color-theme-solarized-autoloads
  (color-theme-initialize)
  (load-theme 'solarized-light t)
  (setq color-theme-is-global t))
