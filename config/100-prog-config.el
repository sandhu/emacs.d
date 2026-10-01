;;; -*- lexical-binding: t; -*-

(setq redisplay-skip-fontification-on-input t)

(defun add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\|NOCOMMIT\\|PENDING\\)"
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

(use-package apheleia :ensure t
  :init
  (apheleia-global-mode +1)
  :hook
  ((clojure-mode clojure-ts-mode org-mode markdown-mode text-mode)
   . (lambda () (apheleia-mode -1))))

(use-package lsp-mode :ensure t
  :commands lsp
  :custom
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-enable-indentation nil)
  (lsp-keymap-prefix "C-c l")
  (lsp-format-buffer-on-save t)
  (lsp-organize-imports-on-save t)
  (lsp-eldoc-render-all nil)
  (lsp-idle-delay 0.6)
  (lsp-file-watch-threshold 6144)
  (lsp-inlay-hint-enable t)
  (lsp-enable-snippet nil)
  (lsp-diagnostics-provider :flycheck)
  (lsp-tailwindcss-add-on-mode t)
  (lsp-tailwindcss-server-path "/opt/homebrew/bin/tailwindcss-language-server")
  :hook
  ((lsp-mode . lsp-ui-mode)))

(use-package lsp-ui :ensure t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-doc-show-with-cursor nil))

(use-package consult :ensure t)

(use-package consult-lsp :ensure t
  :after (lsp-mode consult)
  :bind (:map lsp-mode-map
              ("C-c l p" . consult-lsp-symbols)))

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)
