(when (equal system-type 'darwin)
  ;; osx specific options

  ;; Use spotlight instead of locate
  (setq locate-command "mdfind")

  ;; Always open a file in a new frame
  (setq ns-pop-up-frames t)

  ;; Move to trash when deleting stuff
  (setq delete-by-moving-to-trash t
        trash-directory "~/.Trash/emacs")

  ;; Ignore .DS_Store files with ido mode
  (after 'ido-mode (add-to-list 'ido-ignore-files "\\.DS_Store"))

  ;; Use aspell for spell checking: brew install aspell --lang=en
  (setq ispell-program-name "/usr/local/bin/aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra")))
