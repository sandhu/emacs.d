(defmacro diminish-major-mode (mode new-name)
  `(add-hook (intern (concat (symbol-name ,mode) "-hook"))
             '(lambda () (setq mode-name ,new-name))))

(provide 'teppoudo-diminish)
