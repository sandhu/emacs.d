(setq redisplay-skip-fontification-on-input t)

(defun add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(use-package prog-mode
  :init (setq font-lock-maximum-decoration t)
  :bind ("M-/" . comment-or-uncomment-region)
  :config
  (show-paren-mode)
  (add-watchwords))

(use-package rainbow-delimiters :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package smartscan :ensure t
  :init (add-hook 'prog-mode-hook 'smartscan-mode)
  :config (setq smartscan-symbol-selector "symbol"))

(use-package subword
  :init (add-hook 'prog-mode-hook 'subword-mode)
  :diminish "")

(use-package lsp-mode :ensure t
  :init
  ;;(setq lsp-use-plists t)
  :commands lsp
  :custom
  (lsp-eldoc-render-all nil)
  (lsp-idle-delay 0.6)
  (lsp-inlay-hint-enable t)
  (lsp-diagnostics-provider :flycheck)
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-enable-indentation nil)
  (setq lsp-keymap-prefix "C-c l")
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))


;; (use-package lsp-treemacs :ensure t)

(use-package lsp-ui :ensure t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-doc-enable nil)
  :config
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-show-with-cursor nil))

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)
