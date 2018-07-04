;; The .emacs should declare the following constants:
;; 
;; dotemacs-dir  - the directory of this file.
;; dotemacs-file - the path of this file, roughly (concat dotemacs-dir "gahag.el")

;; The following constants are optional, and
;; are only required by specific functions:
;; 
;; ctags-program - the ctags executable
;; desktop-home  - the parent directory to save desktops
;; packages-home - the parent directory of custom packages


(require 'cl)

;; Add custom packages to load-path
(when (boundp 'packages-home)
      (mapc (lambda (x) (add-to-list 'load-path (expand-file-name x packages-home)))
            (delete ".." (directory-files packages-home))))

(cl-flet ((dotemacs (name) (concat dotemacs-dir name)))
  (load (dotemacs "aliases.el"))
  (load (dotemacs "config.el"))
  (load (dotemacs "modes.el"))
  (load (dotemacs "keys.el"))
  (load (dotemacs "defuns.el"))
  ;; (load (dotemacs "hooks.el"))
  (load (dotemacs "registers.el"))
  (load (dotemacs "etc.el"))
  (load (dotemacs "packages.el"))
  (load (dotemacs "themes/powerline-theme.el")))
