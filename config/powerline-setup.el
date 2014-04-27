(require-package 'powerline)

(defun arrow-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"10 15 2 1\",
\". c %s\",
\"  c %s\",
\".         \",
\"..        \",
\"...       \",
\"....      \",
\".....     \",
\"......    \",
\".......   \",
\"........  \",
\".......   \",
\"......    \",
\".....     \",
\"....      \",
\"...       \",
\"..        \",
\".         \"};"  color1 color2))

(defun arrow-left-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"10 15 2 1\",
\". c %s\",
\"  c %s\",
\"         .\",
\"        ..\",
\"       ...\",
\"      ....\",
\"     .....\",
\"    ......\",
\"   .......\",
\"  ........\",
\"   .......\",
\"    ......\",
\"     .....\",
\"      ....\",
\"       ...\",
\"        ..\",
\"         .\"};"  color2 color1))


(defconst color1 "#002b36") ; "#859900"
(defconst color2 "#586E75")
(defconst color3 "#839496")
(defconst color4 "#002B35")
(defconst fontcolor1 "#FDF6E3")
(defconst fontcolor2 "#EEE8D5")

(defvar arrow-right-1 (create-image (arrow-right-xpm color1 color2)
                                    'xpm t :ascent 'center))
(defvar arrow-right-2 (create-image (arrow-right-xpm color2 "None")
                                    'xpm t :ascent 'center))
(defvar arrow-left-1  (create-image (arrow-left-xpm color2 color3)
                                    'xpm t :ascent 'center))
(defvar arrow-left-2  (create-image (arrow-left-xpm "None" color2)
                                    'xpm t :ascent 'center))

(setq-default mode-line-format
              (list  '(:eval (concat (propertize (concat  " " mode-name) 'face 'mode-line-color-1)
                              (propertize (format-mode-line minor-mode-alist) 'face 'mode-line-color-1)
                              (propertize " " 'face 'mode-line-color-1)
                              (propertize " " 'display arrow-right-1)))
                     '(:eval (concat (propertize " %* %b " 'face 'mode-line-color-2)
                              (propertize " " 'display arrow-right-2)))
                     ;; Justify right by filling with spaces to right fringe - 17
                     ;; (17 should be computed rather than hard-coded)
                     '(:eval (propertize " " 'display '((space :align-to (- right-fringe 17)))))
                     '(:eval (concat (propertize " " 'display arrow-left-2)
                              (propertize
                               (concat " " (replace-regexp-in-string
                                            "%" "%%" (format-mode-line '(-3 "%p"))) " ")
                               'face 'mode-line-color-2)))
                     '(:eval (concat (propertize " " 'display arrow-left-1)
                              (propertize "%4l     " 'face 'mode-line-color-3)))))

(make-face 'mode-line-color-1)
(set-face-attribute 'mode-line-color-1 nil
                    :foreground color1
                    :background fontcolor1)

(make-face 'mode-line-color-2)
(set-face-attribute 'mode-line-color-2 nil
                    :foreground color2
                    :background fontcolor2)

(make-face 'mode-line-color-3)
(set-face-attribute 'mode-line-color-3 nil
                    :foreground color3
                    :background fontcolor1)

(set-face-attribute 'mode-line nil
                    :foreground color4
                    :background "#000"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :foreground color3
                    :background "#000")
