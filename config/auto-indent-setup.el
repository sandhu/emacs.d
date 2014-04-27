(setq auto-indent-on-save-file t)
(setq auto-indent-delete-trailing-whitespace-on-save-file t)
(setq auto-indent-untabify-on-save-file t)

(setq auto-indent-indent-style 'aggressive)

(require-package 'auto-indent-mode)
(auto-indent-global-mode)

;; Temporary fix for a bug in auto-indent-mode.
;; Need to override this function until the pull request is
;; merged and the upstream package is updated
(defun auto-indent-whole-buffer (&optional save)
  "Auto-indent whole buffer and untabify it.

If SAVE is specified, save the buffer after indenting the entire
buffer."
  (interactive)
  (when (auto-indent-aggressive-p)
    (unless (or (minibufferp)
                (memq major-mode auto-indent-disabled-modes-list)
                (and save (memq major-mode auto-indent-disabled-modes-on-save)))
      (when (or
             (and save auto-indent-delete-trailing-whitespace-on-save-file)
             (and (not save) auto-indent-delete-trailing-whitespace-on-visit-file))
        (delete-trailing-whitespace))
      (unless (memq major-mode auto-indent-multiple-indent-modes)
        (when (or
               (and save auto-indent-on-save-file)
               (and (not save) auto-indent-on-visit-file))
          (indent-region (point-min) (point-max) nil)))
      (cond
        ((or (and (not save) (eq auto-indent-untabify-on-visit-file 'tabify))
             (and save (eq auto-indent-untabify-on-save-file 'tabify)))
         (tabify (point-min) (point-max)))
        ((or (and (not save) auto-indent-untabify-on-visit-file)
             (and save auto-indent-untabify-on-save-file))
         (untabify (point-min) (point-max)))))
    nil))
