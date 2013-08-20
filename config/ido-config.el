(require-package 'ido-ubiquitous)

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

(provide 'init-ido)
