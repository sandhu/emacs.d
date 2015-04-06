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
          (setq solarized-high-contrast-mode-line t
                solarized-use-less-bold t
                x-underline-at-descent-line t)
          (load-theme 'solarized-light 'no-confirm))
  :config (setq color-theme-is-global t))

(use-package rainbow-mode :ensure t
  :diminish rainbow-mode)

(use-package string-utils :ensure t)
(use-package dash :ensure t)
(use-package projectile)

(use-package powerline :ensure t
  :init (setq powerline-default-separator 'wave)
  :config (progn
            (defface modes-ml-face '((t (:background "#002b36" :inherit mode-line)))
              "Powerline face for modes section of the mode-line"
              :group 'powerline)
            (defface file-ml-face '((t (:background "#586e75" :inherit mode-line)))
              "Powerline face for file and branch section of the mode-line"
              :group 'powerline)
            (defface line-ml-face '((t (:background "#93a1a1" :inherit mode-line)))
              "Powerline face for file and branch section of the mode-line"
              :group 'powerline)
            (defface pos-ml-face '((t (:background "#586e75" :inherit mode-line)))
              "Powerline face for file and branch section of the mode-line"
              :group 'powerline)
            (defface ml-fill-face '((t (:background "#93a1a1" :inherit mode-line)))
              "Powerline face for file and branch section of the mode-line"
              :group 'powerline)
            (setq-default mode-line-format
                          '("%e"
                            (:eval
                             (let* ((file-name (buffer-file-name (current-buffer)))
                                    (active (powerline-selected-window-active))
                                    (separator-left (intern (format "powerline-%s-%s"
                                                                    (powerline-current-separator)
                                                                    (car powerline-default-separator-dir))))
                                    (separator-right (intern (format "powerline-%s-%s"
                                                                     (powerline-current-separator)
                                                                     (cdr powerline-default-separator-dir))))
                                    (lhs (list (powerline-major-mode 'modes-ml-face 'l)
                                               (powerline-process 'modes-ml-face 'l)
                                               (powerline-minor-modes 'modes-ml-face 'l)
                                               (powerline-raw " " 'modes-ml-face)
                                               (funcall separator-left 'modes-ml-face 'file-ml-face)

                                               (powerline-raw "[" 'file-ml-face)
                                               (powerline-raw (projectile-project-name) 'file-ml-face)
                                               (powerline-raw "] %b %*" 'file-ml-face)
                                               (powerline-raw (concat " "
                                                                      (when (and file-name vc-mode)
                                                                        (concat "(" (-> file-name
                                                                                        vc-working-revision
                                                                                        (string-utils-truncate-to 40))
                                                                                ")")))
                                                              'file-ml-face 'r)
                                               (funcall separator-left 'file-ml-face 'ml-fill-face)))

                                    (rhs (list (powerline-raw global-mode-string 'ml-fill-face 'r)
                                               (funcall separator-right 'ml-fill-face 'pos-ml-face)
                                               (powerline-raw "%p " 'pos-ml-face 'l)
                                               (funcall separator-right 'pos-ml-face 'line-ml-face)

                                               (powerline-raw " %4l " 'line-ml-face 'r))))

                               (concat (powerline-render lhs)
                                       (powerline-fill 'ml-fill-face (powerline-width rhs))
                                       (powerline-render rhs))))))))

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
