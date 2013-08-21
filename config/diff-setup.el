(after 'diff-mode
  (setq diff-switches "-u")
  (set-face-foreground 'diff-added "green4")
  (set-face-foreground 'diff-removed "red3"))
