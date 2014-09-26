(require-package 'flymake-cursor)

;; turn off GUI warnings from flymake because they (calls to message-box)
;; cause Emacs to hang on OS X
(setq flymake-gui-warnings-enabled nil)

;; alias the new `flymake-report-status-slim' to `flymake-report-status'
(defun flymake-report-status-slim (e-w &optional status)
  "Show \"slim\" flymake status in mode line."
  (when e-w
    (setq flymake-mode-line-e-w e-w))
  (when status
    `        (setq flymake-mode-line-status status))
  (let* ((mode-line " Φ"))
    (when (> (length flymake-mode-line-e-w) 0)
      (setq mode-line (concat mode-line ":" flymake-mode-line-e-w)))
    (setq mode-line (concat mode-line flymake-mode-line-status))
    (setq flymake-mode-line mode-line)
    (force-mode-line-update)))
(defalias 'flymake-report-status 'flymake-report-status-slim)
