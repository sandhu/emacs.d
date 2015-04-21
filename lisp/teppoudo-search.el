(defun isearch-remove-unmatched-part ()
  "Remove the failed part of the search string if any, otherwise just delete char"
  (interactive)
  (if (isearch-fail-pos)
      (with-isearch-suspended
       (setq isearch-new-string  (substring isearch-string 0 (or (isearch-fail-pos)
                                                                 (length isearch-string)))
             isearch-new-message (mapconcat 'isearch-text-char-description isearch-new-string "")))
    (isearch-del-char)))

(provide 'teppoudo-search)
