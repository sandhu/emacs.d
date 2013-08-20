;; Use the homebrew version of the git packages
(add-to-list 'load-path "/usr/local/share/git-core/contrib/emacs")
(require 'git)
(require 'git-blame)

(setq git--state-mark-modeline nil)
(add-hook 'git-commit-mode-hook (lambda ()
                                  (auto-fill-mode)
                                  (turn-on-flyspell)
                                  (toggle-save-place 0)
                                  (set-fill-column 72)))

(require-package 'magit)

;; Subtler highlight
;; (set-face-background 'magit-item-highlight "#121212")
;; (set-face-foreground 'diff-context "#666666")
;; (set-face-foreground 'diff-added "#00cc33")
;; (set-face-foreground 'diff-removed "#ff0000")

;; Load git configurations
;;(add-hook 'magit-mode-hook 'magit-load-config-extensions)

;; C-x C-k to kill file on line

(defun magit-kill-file-on-line ()
  "Show file on current magit line and prompt for deletion."
  (interactive)
  (magit-visit-item)
  (delete-current-buffer-file)
  (magit-refresh))

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

;; Ignore whitespace in diffs
(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))

(after 'magit
  (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)
  (define-key magit-status-mode-map (kbd "C-x C-k") 'magit-kill-file-on-line)
  (define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace))

;; git gutter in the fringe
;;(require-package 'git-gutter-fringe)
;;(git-gutter)
