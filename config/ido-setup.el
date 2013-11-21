(require-package 'ido-ubiquitous)
(require-package 'idomenu)
(require-package 'flx-ido)

(after 'ido-ubiquitous-autoloads
  (ido-mode t)
  (ido-ubiquitous t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-auto-merge-work-directories-length nil
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-use-virtual-buffers t
        ido-handle-duplicate-virtual-buffers 2
        ido-max-prospects 10)

  (after 'flx-ido-autoloads
    (flx-ido-mode t)
    ;; disable ido faces to see flx highlights.
    (setq ido-use-faces nil))

  ;; Make ~ get you home. Fast. Bad idea if the file name is prefixed with ~
  (add-hook 'ido-setup-hook
            (lambda ()
              ;; Go straight home
              (define-key ido-file-completion-map
                (kbd "~")
                (lambda ()
                  (interactive)
                  (if (looking-back "/")
                      (insert "~/")
                    (call-interactively 'self-insert-command)))))))
