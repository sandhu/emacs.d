(use-package ido-ubiquitous :ensure t :pin melpa-stable
  :config (progn (ido-mode t)
                 (ido-ubiquitous-mode)
                 (ido-everywhere t)
                 (add-to-list 'ido-ignore-files "\\.DS_Store")
                 (add-hook 'ido-setup-hook
                           (lambda ()
                             ;; Go straight home
                             (define-key ido-file-completion-map (kbd "~")
                               (lambda ()
                                 (interactive)
                                 (if (looking-back "/")
                                     (insert "~/")
                                   (call-interactively 'self-insert-command))))))))

(use-package flx-ido :ensure t :pin melpa-stable
  :init (setq ido-use-faces nil) ; disable ido faces to see flx highlights
  :config (flx-ido-mode t))

(use-package smex :ensure t :pin melpa-stable
  :init (setq smex-save-file (concat user-emacs-directory ".smex-items"))
  :bind (("M-x" . smex)
         ("C-x C-m" . smex)))
