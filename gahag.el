;; The .emacs should declare the following constants:
;; 
;; dotemacs-dir  - the directory of this file.
;; dotemacs-file - the path of this file, roughly (concat dotemacs-dir "gahag.el")

;; The following constants are optional, and
;; are only required by specific functions:
;; 
;; ctags-program - the ctags executable
;; desktop-home  - the parent directory to save desktops


(require 'cl)

;; Relax gc during init 
(setq gc-cons-threshold 50000000)
(add-hook 'emacs-startup-hook (lambda () (setq gc-cons-threshold 800000)))

(cl-flet ((file-name-handler-alist nil) ; Dont run regexes on filenames.
          (dotemacs (name) (concat dotemacs-dir name)))
  (load (dotemacs "defuns.el"))
  (load (dotemacs "desktop.el"))
  (load (dotemacs "packages.el"))
  (load (dotemacs "theming.el")))
