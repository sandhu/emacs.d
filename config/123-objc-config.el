;; Make sure .h files that contain @interface or @protocol get opened
;; as objective-c
(add-to-list 'magic-mode-alist
             `(,(lambda ()
                  (and (string= (file-name-extension buffer-file-name) "h")
                       (or (re-search-forward "@\\<interface\\>"
                                              magic-mode-regexp-match-limit t)
                           (re-search-forward "@\\<protocol\\>"
                                              magic-mode-regexp-match-limit t))))
               . objc-mode))
;; The "other file" for a .h can be a .m or a .mm
(require 'find-file)
;; for the "cc-other-file-alist" variable
(nconc (cadr (assoc "\\.h\\'" cc-other-file-alist)) '(".m" ".mm"))
