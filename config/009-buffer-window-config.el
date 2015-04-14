(use-package ibuffer
  :init (progn
          (setq ibuffer-expert t
                ibuffer-show-empty-filter-groups nil
                ibuffer-formats '((mark modified read-only vc-status-mini " "
                                        (name 18 18 :left :elide) " "
                                        (size-h 9 -1 :right) " "
                                        (mode 16 16 :left :elide) " "
                                        (vc-status 16 16 :left) " "
                                        filename-and-process))
                ibuffer-filter-group-name-face 'font-lock-doc-face)
          (defalias 'list-buffers 'ibuffer))
  :config (progn
            ;; Use human readable Size column instead of original one
            (define-ibuffer-column size-h (:name "Size" :inline t)
              (cond
               ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
               ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
               (t (format "%8d" (buffer-size)))))
            (defun ibuffer-back-to-top ()
              (interactive)
              (beginning-of-buffer)
              (next-line 3))
            (defun ibuffer-jump-to-bottom ()
              (interactive)
              (end-of-buffer)
              (next-line -2))

            (define-key ibuffer-mode-map (vector 'remap 'end-of-buffer) 'ibuffer-jump-to-bottom)
            (define-key ibuffer-mode-map (vector 'remap 'beginning-of-buffer) 'ibuffer-back-to-top)

            (add-hook 'ibuffer-mode-hook
                      (lambda ()
                        (ibuffer-auto-mode 1)
                        (diminish-major-mode 'ibuffer "≣")))))

(use-package ibuffer-vc :ensure t
  :config (progn
            (defun ibuffer-set-up-preferred-filters ()
              (ibuffer-vc-set-filter-groups-by-vc-root)
              (unless (eq ibuffer-sorting-mode 'filename/process)
                (ibuffer-do-sort-by-filename/process)))

            (add-hook 'ibuffer-hook 'ibuffer-set-up-preferred-filters)))

(use-package buffer-move :ensure t
  :bind (("<C-s-up>" . buf-move-up)
         ("<C-s-down>" . buf-move-down)
         ("<C-s-left>" . buf-move-left)
         ("<C-s-right>" . buf-move-right)))

(use-package switch-window :ensure t
  :init (windmove-default-keybindings)
  :bind (("C-x o" . switch-window)
         ("C-M-]" . scroll-other-window)
         ("C-M-[" . scroll-other-window-down)))
