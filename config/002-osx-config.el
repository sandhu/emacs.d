(when (equal system-type 'darwin)
  ;; Use the command key as 'meta'
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super)
  (setq ns-function-modifier 'hyper)

  ;; The osx ls does not support -X or --sort
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil)

  ;; Use spotlight instead of locate
  (setq locate-command "mdfind")

  ;; Always open a file in a new frame
  (setq ns-pop-up-frames t)

  ;; Move to trash when deleting stuff
  (setq delete-by-moving-to-trash t
        trash-directory "~/.Trash/emacs")

  (use-package reveal-in-osx-finder :ensure t))
