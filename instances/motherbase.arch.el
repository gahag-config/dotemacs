;(package-initialize)

(defconst emacs-home  "/gahag/config/emacs/")
(defconst desktop-home  (concat emacs-home "desktops/"))
(defconst dotemacs-dir  (concat emacs-home "dotemacs/"))
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files '("/gahag/org"))

;; features:
(defconst package-features '(feature-lsp
                             feature-pdftools
                             feature-lsp-c
                             feature-lsp-java
                             feature-python
                             feature-rust
                             feature-ledger))


(load dotemacs-file)

(load-X-theme 'doom-gahag-light)
(powerline-gahag-light-theme)

;; ---------------------------------------------------------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 90 :width normal)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-bullets lsp-mode diminish lsp-ui magit multi-term rainbow-mode ccls dired-narrow dired-subtree use-package web-mode lsp-java rg dockerfile-mode json-mode lua-mode use-package-ensure-system-package highlight-indent-guides rust-mode wakatime-mode diff-hl company-lsp cquery lsp-python org togetherly dired-quick-sort dired-ranger ledger-mode try csharp-mode flycheck markdown-mode transpose-frame calfw-org calfw csv-mode yasnippet-snippets yasnippet rainbow-delimiters gruvbox-theme doom-themes flymd flycheck-haskell yaml-mode impatient-mode pdf-tools latex-preview-pane intero lorem-ipsum gh-md markdown-preview-mode powerline omnisharp multiple-cursors heroku-theme helm haskell-mode fsharp-mode flatui-theme expand-region elm-mode company ace-jump-mode))))
