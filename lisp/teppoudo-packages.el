(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent 1))
  `(eval-after-load ,feature
     '(progn ,@body)))

(provide 'teppoudo-packages)
