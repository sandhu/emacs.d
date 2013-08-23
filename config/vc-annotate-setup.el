;; Run vc-annotate in full screen
(defun vc-annotate-quit ()
  "Restores the previous window configuration and kills the vc-annotate buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :vc-annotate-fullscreen))

(after 'vc-annotate
  (defadvice vc-annotate (around fullscreen activate)
    (window-configuration-to-register :vc-annotate-fullscreen)
    ad-do-it
    (delete-other-windows))
  (define-key vc-annotate-mode-map (kbd "q") 'vc-annotate-quit))
