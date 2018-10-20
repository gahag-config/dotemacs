;(package-initialize)

(defconst emacs-home    "/effy/config/emacs/")
(defconst desktop-home  (concat emacs-home "desktops/"))
(defconst dotemacs-dir  (concat emacs-home "dotemacs/"))
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))

;; (defvar org-mode-map (make-sparse-keymap)) ;; Fix for org mode in Emacs 24.3

(load-theme 'misterioso)


(load dotemacs-file)


(powerline-gahag-theme)

;; ---------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a8810eb3e7166f6d1c5825d6de963c45d6d9ea5eb037728c2ff2e0349c4a3a28" default)))
 '(package-selected-packages
   (quote
    (helm-spotify-plus latex-preview-pane togetherly htmlize ledger-mode transpose-frame multiple-cursors ace-jump-mode expand-region intero lsp-python projectile cquery pdf-tools ox-reveal calfw-org calfw dired-quick-sort dired-ranger magit company-lsp lsp-ui lsp-mode flycheck yasnippet-snippets use-package try powerline helm doom-themes company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
