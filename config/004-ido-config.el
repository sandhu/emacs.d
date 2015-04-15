(use-package ido-ubiquitous :ensure t :pin melpa-stable
  :config (progn
            (defun ido-imenu ()
              "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
              (interactive)
              (imenu--make-index-alist)
              (let ((name-and-pos '())
                    (symbol-names '()))
                (flet ((addsymbols (symbol-list)
                                   (when (listp symbol-list)
                                     (dolist (symbol symbol-list)
                                       (let ((name nil) (position nil))
                                         (cond
                                          ((and (listp symbol) (imenu--subalist-p symbol))
                                           (addsymbols symbol))

                                          ((listp symbol)
                                           (setq name (car symbol))
                                           (setq position (cdr symbol)))

                                          ((stringp symbol)
                                           (setq name symbol)
                                           (setq position (get-text-property 1 'org-imenu-marker symbol))))

                                         (unless (or (null position) (null name))
                                           (add-to-list 'symbol-names name)
                                           (add-to-list 'name-and-pos (cons name position))))))))
                  (addsymbols imenu--index-alist))
                ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
                (let ((symbol-at-point (thing-at-point 'symbol)))
                  (when symbol-at-point
                    (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
                           (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                                 (if (string-match regexp symbol) symbol))
                                                               symbol-names))))
                      (when matching-symbols
                        (sort matching-symbols (lambda (a b) (> (length a) (length b))))
                        (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                              matching-symbols)))))
                (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
                       (position (cdr (assoc selected-symbol name-and-pos))))
                  (push-mark (point))
                  (goto-char position))))
            (bind-key "C-c C-i" 'ido-imenu)

            (ido-mode t)
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
