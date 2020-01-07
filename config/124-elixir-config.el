(use-package alchemist :ensure t
  :bind (("C-c M-j" . alchemist-iex-project-run)
         ("C-c C-k" . alchemist-execute-this-buffer))
  :init (add-hook 'elixir-mode-hook (lambda () (add-hook 'before-save-hook 'elixir-format nil t))))
