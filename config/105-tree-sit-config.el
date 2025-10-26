(use-package tree-sitter-langs :ensure t
  :preface
  (let ((tree-sitter-dir (file-name-concat user-emacs-directory "tree-sitter")))
    (unless (file-directory-p tree-sitter-dir)
      (make-directory tree-sitter-dir t))
    (dolist (dylib
             (directory-files-recursively
              (car (directory-files
                    package-user-dir t
                    "^tree-sitter-langs.*"))
              "dylib$"))
      (let ((dylib-file (file-name-nondirectory dylib)))
        (copy-file dylib
                   (file-name-concat
                    tree-sitter-dir
                    (concat "libtree-sitter-" dylib-file)) t)))
    (dolist (mapping
             '((bash-mode . bash-ts-mode)
               (c-mode . c-ts-mode)
               (c++-mode . c++-ts-mode)
               (c-or-c++-mode . c-or-c++-ts-mode)
               (css-mode . css-ts-mode)
               (dockerfile-mode . dockerfile-ts-mode)
               (js-mode . typescript-ts-mode)
               (js2-mode . typescript-ts-mode)
               (json-mode . json-ts-mode)
               (js-json-mode . json-ts-mode)
               (python-mode . python-ts-mode)
               (sh-mode . bash-ts-mode)
               (sh-base-mode . bash-ts-mode)
               (typescript-mode . typescript-ts-mode)))
      (add-to-list 'major-mode-remap-alist mapping))))
