(require 'package)


(defconst package-list '(auto-complete
                         powerline
                         flycheck
                         yasnippet
                         semantic
                         expand-region
                         multiple-cursors
                         helm
                         org))


(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)


(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
