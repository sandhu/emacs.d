(require-package 'magit)
(require-package 'git-blame)
(require-package 'git-commit-mode)
(require-package 'git-rebase-mode)
(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)
(require-package 'git-timemachine)

(setq-default magit-save-some-buffers nil
              magit-process-popup-time 10
              magit-diff-refine-hunk t
              magit-completing-read-function 'magit-ido-completing-read)

(after 'magit
  ;; Don't let magit-status mess up window configurations
  ;; http://whattheemacsd.com/setup-magit.el-01.html
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))

  (defun magit-quit-session ()
    "Restores the previous window configuration and kills the magit buffer"
    (interactive)
    (kill-buffer)
    (when (get-register :magit-fullscreen)
      (ignore-errors
        (jump-to-register :magit-fullscreen)))))

;; When we start working on git-backed files, use git-wip if available
(after 'vc-git
  (global-magit-wip-save-mode)
  (diminish 'magit-wip-save-mode))

;; Use the fringe version of git-gutter
(require-package 'git-gutter-fringe)
(require 'git-gutter-fringe)
(set-face-foreground 'git-gutter-fr:added    "green4")
(set-face-foreground 'git-gutter-fr:modified "grey50")
(set-face-foreground 'git-gutter-fr:deleted  "red3")
(fringe-helper-define 'git-gutter-fr:added nil
  "........"
  "...XX..."
  "...XX..."
  "XXXXXXXX"
  "XXXXXXXX"
  "...XX..."
  "...XX..."
  "........")
(fringe-helper-define 'git-gutter-fr:modified nil
  "........"
  "XXXXX..."
  "XXXXX..."
  "XXXXX..."
  "XXXXX..."
  "XXXXX..."
  "XXXXX..."
  "........")

(global-git-gutter-mode)

(require-package 'git-messenger)
