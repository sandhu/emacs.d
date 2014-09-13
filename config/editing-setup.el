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

(require-package 'ace-jump-mode)

;; Annoying arrows mode
(require-package 'annoying-arrows-mode)
(global-annoying-arrows-mode)

(add-hook 'text-mode-hook
          (lambda ()
            (setq mode-name "Ƭ")
            (turn-on-auto-fill)
            (setq flyspell-issue-message-flag nil)
            (turn-on-flyspell)))

;; Move lines
(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))

(global-set-key (kbd "<C-S-down>") 'move-line-down)
(global-set-key (kbd "<C-S-up>") 'move-line-up)

;; Create new lines above or below even if in the middle of a line
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

(defun kill-region-or-backward-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
      (backward-kill-word 1)))

(defun kill-to-beginning-of-line ()
  (interactive)
  (kill-region (save-excursion (beginning-of-line) (point))
               (point)))

;; recentf
(recentf-mode t)
(setq recentf-max-saved-items 50)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file
       (ido-completing-read
        "Find recent file: "
        (mapcar 'abbreviate-file-name recentf-list) nil t))
      (message "Opening file...")
    (message "Aborting")))

;; Line number based navigation
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
       (progn
         (linum-mode 1)
         (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))
(global-set-key [remap goto-line] 'goto-line-with-feedback)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; Ensure that when we navigate to a file in an archive, it is opened as
;; read-only by default. Primarily there to prevent unintentional editing
;; of jar files
(autoload 'archive-extract-hook "arc-mode")
(add-hook 'archive-extract-hook (lambda () (toggle-read-only 1)))
