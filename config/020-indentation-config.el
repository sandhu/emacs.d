(use-package whitespace :ensure t
  :init
  (setq whitespace-style '(face tabs empty trailing lines-tail))
  (add-hook 'before-save-hook 'whitespace-cleanup)
  :diminish whitespace-mode)

(defun indent-buffer-on-save ()
  (interactive)
  (unless (derived-mode-p 'yaml-mode)
    (indent-region (point-min) (point-max))))

(use-package aggressive-indent :ensure t
  :init
  (add-hook 'before-save-hook 'indent-buffer-on-save)
  :config
  (add-to-list 'aggressive-indent-excluded-modes 'makefile-mode 'yaml-mode)
  (global-aggressive-indent-mode 1)
  (bind-key "C-c C-q" nil aggressive-indent-mode-map)
  :diminish aggressive-indent-mode)
