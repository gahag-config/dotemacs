;; The .emacs should declare the following constants:
;; 
;; dotemacs-dir  - the directory of this file.
;; dotemacs-file - the path of this file, roughly (concat dotemacs-dir "gahag.emacs")

;; The following constants are optional, and
;; are only required by specific functions:
;; 
;; ctags-program - the ctags executable
;; desktop-home  - the parent directory to save desktops


(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

(cl-flet ((dotemacs (name) (concat dotemacs-dir name)))
  (load (dotemacs "config.emacs"))
  (load (dotemacs "modes.emacs"))
  (load (dotemacs "keys.emacs"))
  (load (dotemacs "defuns.emacs"))
  (load (dotemacs "hooks.emacs"))
  (load (dotemacs "registers.emacs"))
  (load (dotemacs "etc.emacs")))
