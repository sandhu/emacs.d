(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1)
  (menu-bar-mode -1))

;; Special work to do ONLY when there is a window system being used
(if window-system
    (progn
      (add-hook 'after-init-hook 'load-frameg)
      (add-hook 'kill-emacs-hook 'save-frameg)))

;; visual window switcher
(require-package 'switch-window)
(require 'switch-window)

;; rotate windows
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows) 1)) (message "You can't rotate a single window!"))
        (t (let ((i 1)
                 (num-windows (count-windows)))
             (while  (< i num-windows)
               (let* ((w1 (elt (window-list) i))
                      (w2 (elt (window-list) (+ (% i num-windows) 1)))
                      (b1 (window-buffer w1))
                      (b2 (window-buffer w2))
                      (s1 (window-start w1))
                      (s2 (window-start w2)))
                 (set-window-buffer w1  b2)
                 (set-window-buffer w2 b1)
                 (set-window-start w1 s2)
                 (set-window-start w2 s1)
                 (setq i (1+ i))))))))

;; Custom functions/hooks for persisting/loading frame geometry upon save/load
(defun save-frameg ()
  "Gets the current frame's geometry and saves to ~/.emacs.d/emacs.frameg."
  (let ((frameg-font (frame-parameter (selected-frame) 'font))
        (frameg-left (frame-parameter (selected-frame) 'left))
        (frameg-top (frame-parameter (selected-frame) 'top))
        (frameg-width (frame-parameter (selected-frame) 'width))
        (frameg-height (frame-parameter (selected-frame) 'height))
        (frameg-file (expand-file-name "emacs.frameg" user-emacs-directory)))
    (with-temp-buffer
      ;; Turn off backup for this file
      (make-local-variable 'make-backup-files)
      (setq make-backup-files nil)
      (insert
       ";;; This file stores the previous emacs frame's geometry.\n"
       ";;; Last generated " (current-time-string) ".\n"
       "(setq initial-frame-alist\n"
       " '((font . \"" frameg-font "\")\n"
       (format " (top . %d)\n" (max frameg-top 0))
       (format " (left . %d)\n" (max frameg-left 0))
       (format " (width . %d)\n" (max frameg-width 0))
       (format " (height . %d)))\n" (max frameg-height 0)))
      (when (file-writable-p frameg-file)
        (write-file frameg-file)))))

(defun load-frameg ()
  "Loads ~/.emacs.frameg which should load the previous frame's geometry."
  (let ((frameg-file (expand-file-name "emacs.frameg" user-emacs-directory)))
    (when (file-readable-p frameg-file)
      (load-file frameg-file))))
