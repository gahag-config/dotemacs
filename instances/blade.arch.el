;(package-initialize)

(defconst emacs-home    "/gahag/config/emacs/")
(defconst desktop-home  (concat emacs-home "desktops/"))
(defconst dotemacs-dir  (concat emacs-home "dotemacs/"))
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files '("/gahag/org"))

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
    (pdf-tools powerline dockerfile-mode js2-mode json-mode lua-mode use-package-ensure-system-package web-mode gradle-mode highlight-indent-guides projectile pcap-mode rust-mode yasnippet-snippets yasnippet lsp-rust csv-mode lsp-java lsp-ui markdown-mode jsx-mode rainbow-mode ox-reveal togetherly arduino-mode company-arduino company-lsp cquery lsp-mode lsp-python dired-quick-sort try htmlize ledger-mode calfw calfw-org company doom-themes shm transpose-frame use-package dired-ranger latex-preview-pane magit intero nyan-mode ace-jump-mode flymake-haskell-multi haskell-mode helm multiple-cursors expand-region flycheck auto-complete))))
