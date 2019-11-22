;(package-initialize)

(require 'xdg)

(defconst desktop-home  (concat (xdg-data-home) "/emacs/desktops/"))
(defconst dotemacs-dir  "/gahag/config/emacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files '("/gahag/org"))

;; (defvar org-mode-map (make-sparse-keymap)) ;; Fix for org mode in Emacs 24.3

;; features:
(defconst package-features '(feature-ob-async
                             feature-ob-mongo
                             feature-docker
                             feature-pdftools
                             feature-python
                             feature-lsp
                             feature-lsp-c
                             feature-lua
                             feature-lsp-lua
                             feature-javascript
                             feature-restclient
                             feature-org-reveal
                             feature-haskell))

(load dotemacs-file)

(load-X-theme 'doom-gahag-light)
(powerline-gahag-light-theme)

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
    (ccls company docker docker-tramp doom-themes flycheck helm lsp-mode lsp-ui lua-mode magit markdown-mode multi-term ob-async ob-restclient org org-re-reveal pdf-tools restclient rg rust-mode use-package web-mode wgrep yaml-mode yasnippet yasnippet-snippets puppet-mode multi-line org-bullets diminish dired-subtree dired-narrow ob-mongo js2-mode rainbow-mode dockerfile-mode json-mode wakatime-mode togetherly ledger-mode transpose-frame multiple-cursors ace-jump-mode expand-region highlight-indent-guides intero lsp-java calfw-org calfw dired-quick-sort dired-ranger company-lsp try powerline))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "adobe" :slant normal :weight normal :height 110 :width normal)))))
