;; brew install eslint
(use-package lsp-eslint :demand t
  :after lsp-mode)

(use-package tree-sitter-langs
  :mode (("\\.js\\'"  . typescript-ts-mode)
         ("\\.jsx\\'" . tsx-ts-mode)
         ("\\.mjs\\'" . typescript-ts-mode)
         ("\\.mts\\'" . typescript-ts-mode)
         ("\\.cjs\\'" . typescript-ts-mode)
         ("\\.ts\\'"  . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)
         ("\\.json\\'" .  json-ts-mode)))

;; brew install typescript-language-server

(use-package lsp-mode :ensure t
  :hook ((tsx-ts-mode typescript-ts-mode js-ts-mode) . lsp-deferred))

(use-package prettier-js :ensure t
  :init (setq prettier-js-use-modules-bin t)
  :hook ((tsx-ts-mode typescript-ts-mode js-ts-mode) . prettier-js-mode))

(defconst combobulate-path (file-name-concat user-emacs-directory "combobulate"))

(use-package combobulate
  :custom
  ;; You can customize Combobulate's key prefix here.
  ;; Note that you may have to restart Emacs for this to take effect!
  (combobulate-key-prefix "C-c o")
  :hook ((prog-mode . combobulate-mode))
  ;; Amend this to the directory where you keep Combobulate's source
  ;; code.
  :load-path combobulate-path)
