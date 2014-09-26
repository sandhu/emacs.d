;; Setup the package management
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; This allows you to specify what repository to download a particular package from
;; But it only works on Emacs 24.4, and pretest versions are given a 24.3 numbering scheme,
;; so to make things simple we'll just ignore any potential errors
(ignore-errors
  (setq package-pinned-archives '((clojure-mode . "melpa-stable")
                                  (cider . "melpa-stable"))))

;; On demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      (require package)
      (if (or (assoc package package-archive-contents) no-refresh)
          (progn
            (package-install package)
            (require-package package min-version t))
          (progn
            (package-refresh-contents)
            (require-package package min-version t)))))

(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent 1))
  `(eval-after-load ,feature
     '(progn ,@body)))

;; Fire up the package manager
(package-initialize)

(provide 'init-packages)
