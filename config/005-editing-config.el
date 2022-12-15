;; Global defaults
(setq-default indent-tabs-mode nil) ; Always use spaces for indent
(setq tab-width 2
      standard-indent 2
      line-number-mode t
      column-number-mode t
      sentence-end-double-space t
      shift-select-mode nil
      mouse-yank-at-point t)
(delete-selection-mode)

;; support the "dangerous" commands :-)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-hook 'text-mode-hook
          (lambda ()
            (setq mode-name "Ƭ")
            (turn-on-auto-fill)))

(use-package teppoudo-editing
  :load-path "lisp/"
  :bind (([remap goto-line] . goto-line-with-feedback)
         ([remap move-beginning-of-line] . smarter-move-beginning-of-line)
         ("<C-return>" . open-line-below)
         ("<C-S-return>" . open-line-above)
         ("<C-S-down>" . move-line-down)
         ("<C-S-up>" . move-line-up)
         ("S-SPC" . just-one-space)
         ("M-j" . swallow-newline)
         ("C-w" . kill-region-or-backward-word)))

(use-package teppoudo-search
  :load-path "lisp/"
  :init (bind-key "<backspace>" 'isearch-remove-unmatched-part isearch-mode-map))

(use-package expand-region :ensure t
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

(use-package undo-tree :ensure t
  :config (progn
            (setq undo-tree-auto-save-history nil)
            (global-undo-tree-mode)
            (diminish-major-mode 'undo-tree-visualizer-mode "⅄"))
  :diminish ((undo-tree-mode . "")))

(use-package browse-kill-ring :ensure t
  :config (browse-kill-ring-default-keybindings))

(use-package avy :ensure t :pin melpa-stable
  :bind (("C-." . avy-goto-word-or-subword-1)
         ("C-o" . avy-goto-word-or-subword-1)))

(use-package multiple-cursors :ensure t :pin melpa-stable
  :config (progn
            (setq mc/always-run-for-all t)
            (define-key mc/keymap (kbd "<return>") nil))
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C->" . mc/mark-all-like-this)
         ("C-S-c C-S-c" . mc/edit-lines)
         ("C-S-c C-e" . mc/edit-ends-of-lines)))

;; Ensure that when we navigate to a file in an archive, it is opened as
;; read-only by default. Primarily there to prevent unintentional editing
;; of jar files
(use-package arc-mode
  :init (add-hook 'archive-extract-hook (lambda () (toggle-read-only 1))))

(use-package lorem-ipsum :ensure t)

(use-package goto-chg :ensure t
  :bind (("C-M-," . goto-last-change)
         ("C-M-." . goto-last-change-reverse)))
