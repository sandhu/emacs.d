(require-package 'smex)

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
