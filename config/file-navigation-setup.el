(require-package 'ack-and-a-half)
(require-package 'find-file-in-project)

(after 'find-file-in-project-autoloads
  ;; Helper methods to create local settings
  (defun ffip--create-exclude-find-options (names)
    (mapconcat (lambda (name)
                 (concat "-not -regex \".*" name ".*\"")) names " "))

  (defun ffip-local-excludes (&rest names)
    (set (make-local-variable 'ffip-find-options)
         (ffip--create-exclude-find-options names)))

  (defun ffip-local-patterns (&rest patterns)
    (set (make-local-variable 'ffip-patterns) patterns))

  ;; Function to create new functions that look for a specific pattern
  (defun ffip-create-pattern-file-finder (&rest patterns)
    (lexical-let ((patterns patterns))
      (lambda ()
        (interactive)
        (let ((ffip-patterns patterns))
          (find-file-in-project)))))

  ;; Use eproject to find project root
  (setq ffip-project-root-function 'eproject-root)

  ;; No need to be stingy
  (setq ffip-limit 4096)

  ;; Default excludes - override with ffip-local-excludes
  (setq ffip-find-options
        (ffip--create-exclude-find-options
         '("node_modules" "target" "overlays" "vendor")))

  ;; Function to create new functions that look for a specific pattern
  (defun ffip-create-pattern-file-finder (&rest patterns)
    (lexical-let ((patterns patterns))
      (lambda ()
        (interactive)
        (let ((ffip-patterns patterns))
          (find-file-in-project))))))

(after 'find-file-in-project
  (add-to-list 'ffip-patterns "*.clj")
  (add-to-list 'ffip-patterns "*.edn")
  (add-to-list 'ffip-patterns "*.dtm"))
