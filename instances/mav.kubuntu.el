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
    (org-bullets php-mode 0blayout multi-term diminish ob-async haskell-mode ob-restclient ccls restclient org-re-reveal dired-subtree dired-narrow magit web-mode org ob-mongo rg lua-mode js2-mode rainbow-mode docker dockerfile-mode json-mode wakatime-mode togetherly ledger-mode transpose-frame multiple-cursors ace-jump-mode expand-region highlight-indent-guides intero rust-mode lsp-java pdf-tools calfw-org calfw dired-quick-sort dired-ranger company-lsp lsp-ui lsp-mode projectile flycheck yasnippet-snippets yasnippet company helm doom-themes try powerline use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 110 :width normal)))))
