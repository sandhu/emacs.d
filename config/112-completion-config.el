;;; -*- lexical-binding: t; -*-

(use-package company :ensure t
  :init (setq company-idle-delay
              (lambda () (if (company-in-string-or-comment) nil 0.2)))
  :config (global-company-mode)
  :diminish " α")

(use-package company-fuzzy
  :ensure t
  :init
  (with-eval-after-load 'company
    (company-fuzzy-mode 1)))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package vertico-directory :ensure nil ; Part of the vertico package
  :after vertico
  :bind (:map vertico-map
              ("M-DEL" . vertico-directory-up)))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (orderless-matching-styles '(orderless-literal
                               orderless-prefixes
                               orderless-initialism
                               orderless-flex)))
