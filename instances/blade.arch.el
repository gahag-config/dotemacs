;(package-initialize)

(require 'xdg)

(defconst desktop-home  (concat (xdg-data-home) "/emacs/desktops/"))
(defconst dotemacs-dir  "/gahag/config/emacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files '("/gahag/org"))

;; features:
(defconst package-features '(feature-lsp
                             feature-lsp-c
                             feature-pdftools
                             feature-lsp-c
                             feature-lsp-java
                             feature-python
                             feature-rust
                             feature-yaml
                             feature-docker
                             feature-ledger
                             feature-org-reveal
                             feature-langtool))

(load dotemacs-file)

(load-X-theme 'doom-gahag-light)
(powerline-gahag-light-theme)

;; ---------------------------------------------------------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 95 :width normal)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-snippets php-mode restclient vterm langtool use-package web-mode cmake-mode org-chef org org-re-reveal rg rust-mode org-ref multi-line csharp-mode ccls diminish dired-narrow dired-subtree multi-term org-bullets docker csv yaml-mode helm intero multiple-cursors lsp-java lsp-mode lsp-ui magit powerline yasnippet wgrep ein dockerfile-mode json-mode lua-mode use-package-ensure-system-package gradle-mode highlight-indent-guides pcap-mode lsp-rust csv-mode jsx-mode rainbow-mode ox-reveal togetherly arduino-mode company-arduino company-lsp cquery lsp-python dired-quick-sort try ledger-mode calfw calfw-org company doom-themes shm transpose-frame dired-ranger latex-preview-pane nyan-mode ace-jump-mode flymake-haskell-multi haskell-mode expand-region flycheck auto-complete))))
