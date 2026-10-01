;;; -*- lexical-binding: t; -*-

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

;; brew install biome

(use-package lsp-mode :ensure t
  :hook ((tsx-ts-mode typescript-ts-mode js-ts-mode) . lsp-deferred)
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("npx" "tsc" "--lsp" "--stdio"))
    :activation-fn (lsp-activate-on "typescript-ts" "typescriptreact")
    :server-id 'ts-ls))
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-javascript-format-enable nil)
  (setq lsp-typescript-format-enable nil))

;; Fix Typescript support for TS7
(with-eval-after-load 'lsp-javascript
  (defcustom lsp-clients-typescript7-path "tsc"
    "Path to the TypeScript 7 native binary (supports `tsc --lsp --stdio`)."
    :group 'lsp-typescript
    :type 'string)

  (defun lsp-clients-typescript7-find-binary ()
    "Prefer the project-local TS7 binary, fall back to PATH."
    (or (when-let* ((root (locate-dominating-file default-directory "node_modules")))
          (let ((local (expand-file-name "node_modules/.bin/tsc" root)))
            (when (file-executable-p local) local)))
        (executable-find lsp-clients-typescript7-path)))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     (lambda ()
                       (list (or (lsp-clients-typescript7-find-binary) "tsc")
                             "--lsp" "--stdio")))
    :activation-fn 'lsp-typescript-javascript-tsx-jsx-activate-p
    :priority -2
    :initialization-options (lambda () (list :supportsHoverVerbosity t))
    :server-id 'ts7-ls)))

;; Fixes bug in lsp-mode that crashes ts7's lsp
(defun my/lsp--strip-null-values (data)
  "Recursively remove plist/hash-table/alist keys whose value is nil."
  (cond
   ((hash-table-p data)
    (let ((new (make-hash-table :test 'equal)))
      (maphash (lambda (k v)
                 (unless (null v)
                   (puthash k (my/lsp--strip-null-values v) new)))
               data)
      new))
   ;; plist: (:key val :key val ...)
   ((and (consp data) (keywordp (car data)))
    (let (result)
      (cl-loop for (k v) on data by #'cddr
               unless (null v)
               do (push k result) (push (my/lsp--strip-null-values v) result))
      (nreverse result)))
   ;; alist: ((key . val) (key . val) ...)
   ((and (consp data) (consp (car data)) (not (listp (caar data))))
    (--keep (unless (null (cdr it)) (cons (car it) (my/lsp--strip-null-values (cdr it)))) data))
   ((vectorp data) (cl-map 'vector #'my/lsp--strip-null-values data))
   (t data)))

(defvar my/lsp--strip-null-server-ids '(ts7-ls)
  "Server IDs whose outgoing LSP messages should have null values stripped.")

(defun my/lsp--should-strip-nulls-p ()
  "Non-nil if the in-flight LSP message is destined for a server
in `my/lsp--strip-null-server-ids'."
  (and (boundp 'lsp--cur-workspace)
       lsp--cur-workspace
       (memq (lsp--client-server-id (lsp--workspace-client lsp--cur-workspace))
             my/lsp--strip-null-server-ids)))

(defun my/lsp--make-message-strip-nulls (args)
  (if (my/lsp--should-strip-nulls-p)
      (list (my/lsp--strip-null-values (car args)))
    args))

(with-eval-after-load 'lsp-mode
  (advice-add 'lsp--make-message :filter-args #'my/lsp--make-message-strip-nulls))


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

(use-package prisma-ts-mode
  :ensure t
  :mode "\\.prisma\\'"
  :init
  (unless (treesit-language-available-p 'prisma)
    (add-to-list 'treesit-language-source-alist
                 '(prisma "https://github.com/victorhqc/tree-sitter-prisma"))
    (treesit-install-language-grammar 'prisma))
  :config
  (setq-local apheleia-inhibit t))

(use-package lsp-mode
  :hook (prisma-ts-mode . lsp-deferred)
  :config
  (add-to-list 'lsp-language-id-configuration '(prisma-ts-mode . "prisma")))
