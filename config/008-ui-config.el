(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1)
  (menu-bar-mode -1)
  (desktop-save-mode 1))

(diminish 'auto-fill-function "")
(after 'abbrev (diminish 'abbrev-mode " ⠤"))
(after 'hideshow (diminish 'hs-minor-mode ""))
(after 'yasnippet (diminish 'yas-minor-mode " ʏ"))

(use-package solarized-theme :ensure t
  :init (progn
          (setq solarized-high-contrast-mode-line t)
          (load-theme 'solarized-light 'no-confirm))
  :config (setq color-theme-is-global t))

(use-package powerline :ensure t
  :init (setq powerline-default-separator 'wave)
  :config (setq-default mode-line-format
                        '("%e"
                          (:eval
                           (let* ((active (powerline-selected-window-active))
                                  (mode-line (if active 'mode-line 'mode-line-inactive))
                                  (face1 (if active 'powerline-active1 'powerline-inactive1))
                                  (face2 (if active 'powerline-active2 'powerline-inactive2))
                                  (separator-left (intern (format "powerline-%s-%s"
                                                                  (powerline-current-separator)
                                                                  (car powerline-default-separator-dir))))
                                  (separator-right (intern (format "powerline-%s-%s"
                                                                   (powerline-current-separator)
                                                                   (cdr powerline-default-separator-dir))))
                                  (lhs (list (powerline-major-mode face2 'l)
                                             (powerline-process face2)
                                             (powerline-minor-modes face2 'l)
                                             (powerline-raw " " face2)
                                             (funcall separator-left face2 face1)

                                             (powerline-raw "%* %b" face1 'l)
                                             (powerline-vc face1 'l)
                                             (powerline-raw " " face1)
                                             (funcall separator-left face1 face2)))

                                  (rhs (list (powerline-raw global-mode-string face2 'r)
                                             (funcall separator-right face2 face1)

                                             (unless window-system
                                               (powerline-raw (char-to-string #xe0a1) face1 'l))
                                             (powerline-raw "%p " face1 'l)
                                             (funcall separator-right face1 mode-line)

                                             (powerline-raw "%4l " nil 'r))))

                             (concat (powerline-render lhs)
                                     (powerline-fill face2 (powerline-width rhs))
                                     (powerline-render rhs)))))))


(use-package popwin :ensure t
  :init (setq display-buffer-function 'popwin:display-buffer
              popwin:special-display-config
              '(("*Help*"  :height 30 :stick t)
                ("*Completions*" :noselect t)
                ("*compilation*" :noselect t)
                ("*Messages*" :height 30)
                ("*Occur*" :noselect t)
                ("\\*Slime Description.*" :noselect t :regexp t :height 30)
                ("\\*Slime Inspector.*" :regexp t :height 30)
                ("*sldb.*":regexp t :height 30)
                ("*magit-commit*" :noselect t :height 40 :width 80)
                ("*magit-diff*" :noselect t :height 40 :width 80)
                ("*magit-edit-log*" :noselect t :height 15 :width 80)
                ("*Ido Completions*" :noselect t :height 30)
                ("*eshell*" :height 30)
                ("*shell*" :height 30)
                ("\\*ansi-term\\*.*" :regexp t :height 30)
                (".*overtone.log" :regexp t :height 30)
                ("*gists*" :height 30)
                ("*Kill Ring*" :height 30)
                ("*Compile-Log*" :height 30)
                (" *auto-async-byte-compile*" :height 14 :position bottom)
                ("*VC-log*" :height 10 :position bottom)

                ("*nREPL doc*" :height 30 :position bottom)
                ("*nREPL error*" :height 30 :position bottom)
                ("*nREPL inspect*" :height 20 :position bottom)
                ("*nREPL Macroexpansion*" :height 30 :position bottom)
                ("nREPL-tmp" :height 30 :position bottom))))
