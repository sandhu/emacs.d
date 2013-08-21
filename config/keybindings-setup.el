;; Make it hard to quit Emacs - C-x Really Quit
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)
(defun kill-buffer-and-frame ()
  (interactive)
  (kill-buffer)
  (delete-frame))
(global-set-key (kbd "C-x C-c") 'kill-buffer-and-frame)

;; Use the command key as 'meta'
;; (setq mac-right-command-modifier 'meta)
;; (setq ns-left-option-modifier 'super)
;; (setq ns-function-modifier 'hyper)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq ns-function-modifier 'hyper)

;; Use C-x C-m to do M-x per Steve Yegge's advice
(global-set-key (kbd "C-x C-m") 'smex)

;; Text size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; window and buffer movement
;; Window switching
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x -") 'rotate-windows)
(global-set-key (kbd "C-x C--") 'toggle-window-split)
(global-unset-key (kbd "C-x C-+")) ;; don't zoom like this

;; scroll other window
(global-set-key (kbd "C-M-]") 'scroll-other-window)
(global-set-key (kbd "C-M-[") 'scroll-other-window-down)

(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward)
(global-set-key (kbd "C-M-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-r") 'isearch-backward-regexp)

;; Ace jump mode
(after 'ace-jump-mode-autoloads
  (global-set-key (kbd "C-o") 'ace-jump-mode))

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t p") 'transpose-params)

;; Killing text
(global-set-key (kbd "C-S-k") 'kill-and-retry-line)
(global-set-key (kbd "C-w") 'kill-region-or-backward-word)
(global-set-key (kbd "M-k") 'kill-to-beginning-of-line)
(global-set-key (kbd "M-j") (lambda ()
                              (interactive)
                              (join-line -1)))

;; prog mode bindings
(global-set-key (kbd "M-/") 'comment-or-uncomment-region)

;; Removing spaces
(global-set-key (kbd "C-c j") 'just-one-space)


(after 'ido-ubiquitous-autoloads
  ;; Jump to a definition in the current file. (This is awesome)
  (global-set-key (kbd "C-x C-i") 'ido-imenu)

  ;; File finding
  (global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
  (global-set-key (kbd "C-x f") 'recentf-ido-find-file)
  (global-set-key (kbd "C-x C-p") 'find-or-create-file-at-point)
  (global-set-key (kbd "C-x M-p") 'find-or-create-file-at-point-other-window)
  (global-set-key (kbd "C-c y") 'bury-buffer)
  (global-set-key (kbd "C-c r") 'revert-buffer)
  (global-set-key (kbd "M-`") 'file-cache-minibuffer-complete))

;; Edit file with sudo
(global-set-key (kbd "M-s e") 'sudo-edit)

;; Copy file path to kill ring
(global-set-key (kbd "C-x M-w") 'copy-current-file-path)

;; Navigation bindings
(global-set-key (vector 'remap 'goto-line) 'goto-line-with-feedback)

;; Move more quickly
(global-set-key (kbd "C-S-n") (lambda () (interactive) (ignore-errors (next-line 5))))
(global-set-key (kbd "C-S-p") (lambda () (interactive) (ignore-errors (previous-line 5))))
(global-set-key (kbd "C-S-f") (lambda () (interactive) (ignore-errors (forward-char 5))))
(global-set-key (kbd "C-S-b") (lambda () (interactive) (ignore-errors (backward-char 5))))

;; Smart navigation
(require-package 'smart-forward)
(after 'smart-forward-autoloads
  (require 'smart-forward)
  (global-set-key (kbd "s-<up>") 'smart-up)
  (global-set-key (kbd "s-<down>") 'smart-down)
  (global-set-key (kbd "s-<left>") 'smart-backward)
  (global-set-key (kbd "s-<right>") 'smart-forward))

;; Expand region
(after 'expand-region-autoloads
  (global-set-key (kbd "C-=") 'er/expand-region))

;; dired
(after 'dired
  (define-key dired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)

  (define-key dired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
  ;;(define-key dired-mode-map (vector 'remap 'smart-up) 'dired-back-to-top)
  (define-key dired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)
  ;;(define-key dired-mode-map (vector 'remap 'smart-down) 'dired-jump-to-bottom)

  ;; Delete with C-x C-k to match file buffers and magit
  (define-key dired-mode-map (kbd "C-x C-k") 'dired-do-delete))

(after 'wdired
  (define-key wdired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
  (define-key wdired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
  (define-key wdired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom))

;; Find File in Project
(after 'find-file-in-project-autoloads
  (global-set-key (kbd "C-x p") 'find-file-in-project))

;; Git
(after 'git
  (global-set-key (kbd "C-x v f") 'vc-git-grep))

(after 'git-messenger-autoloads
  (global-set-key (kbd "C-x v p") #'git-messenger:popup-message))

(after 'magit
  (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)
  (define-key magit-status-mode-map (kbd "C-x C-k") 'magit-kill-file-on-line)
  (define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace))

;; auto-complete
(after 'auto-complete
  (define-key ac-completing-map (kbd "C-M-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-M-p") 'ac-previous)
  (define-key ac-completing-map "\t" 'ac-complete)
  (define-key ac-completing-map (kbd "M-RET") 'ac-help)
  (define-key ac-completing-map "\r" 'nil))

;; clojure
(after 'clojure
  (define-key clojure-mode-map (kbd "C-:") 'toggle-clj-keyword-string))

(after 'nrepl-ritz
  (define-key nrepl-interaction-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
  (define-key nrepl-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
  (define-key nrepl-interaction-mode-map (kbd "C-c C-a") 'nrepl-apropos)
  (define-key nrepl-mode-map (kbd "C-c C-a") 'nrepl-apropos))

(after 'ac-nrepl
  (after 'nrepl
    (define-key nrepl-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)
    (define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)))
