(setq js-indent-level 2)

(use-package tree-sitter-langs
  :mode (("\\.js\\'"  . typescript-ts-mode)
         ("\\.jsx\\'" . tsx-ts-mode)
         ("\\.mjs\\'" . typescript-ts-mode)
         ("\\.mts\\'" . typescript-ts-mode)
         ("\\.cjs\\'" . typescript-ts-mode)
         ("\\.ts\\'"  . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)
         ("\\.json\\'" .  json-ts-mode)))

;; brew install typescript typescript-language-server biome

(use-package lsp-mode :ensure t
  :hook ((tsx-ts-mode typescript-ts-mode js-ts-mode) . lsp-deferred)
  :config
  (setq lsp-clients-typescript-prefer-use-project-ts-server t)
  (setq lsp-javascript-format-enable nil)
  (setq lsp-typescript-format-enable nil))

(use-package lsp-biome :ensure t
  :vc (:url "https://github.com/cxa/lsp-biome" :rev :newest)
  :config
  (add-hook 'lsp-biome-active-hook
            (lambda ()
              (setq-local lsp-format-buffer-on-save nil
                          lsp-organize-imports-on-save nil
                          apheleia-formatter '(biome)
                          before-save-hook (lambda ()
                                             (whitespace-cleanup)
                                             (lsp-biome-organize-imports)
                                             (lsp-biome-fix-all))))))

(defun typescript-setup ()
  (enable-paredit-mode))

(add-hook 'typescript-ts-mode-hook #'typescript-setup)
(add-hook 'tsx-ts-mode-hook #'typescript-setup)

(defconst combobulate-path
  (file-name-concat user-emacs-directory "combobulate"))

(use-package combobulate
  :custom
  ;; You can customize Combobulate's key prefix here.
  ;; Note that you may have to restart Emacs for this to take effect!
  (combobulate-key-prefix "C-c o")
  :hook ((prog-mode . combobulate-mode))
  ;; Amend this to the directory where you keep Combobulate's source
  ;; code.
  :load-path combobulate-path)
