(defun ibuffer-back-to-top ()
  (interactive)
  (beginning-of-buffer)
  (next-line 3))

(defun ibuffer-jump-to-bottom ()
  (interactive)
  (end-of-buffer)
  (next-line -2))

(eval-after-load 'ibuffer
  '(progn
    (define-key ibuffer-mode-map
     (vector 'remap 'end-of-buffer) 'ibuffer-jump-to-bottom)
    (define-key ibuffer-mode-map
     (vector 'remap 'beginning-of-buffer) 'ibuffer-back-to-top)))
