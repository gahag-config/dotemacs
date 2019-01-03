;(package-initialize)

(defconst emacs-home    "/gahag/config/emacs/")
(defconst desktop-home  (concat emacs-home "desktops/"))
(defconst dotemacs-dir  (concat emacs-home "dotemacs/"))
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files '("/gahag/org"))

(load dotemacs-file)

(load-X-theme 'doom-gahag)
(powerline-gahag-theme)

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
 '(custom-safe-themes
   (quote
    ("07d6ef21ab59e51de10f36427758282b449ec4a28e04ebfd2c83bf4cb66aa28b" "4edd229ac234ab8682f54c4ec65995cff2951d6af107a8c183c041b63e9f7194" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(package-selected-packages
   (quote
    (lsp-rust rust-mode csv-mode lsp-java lsp-ui markdown-mode jsx-mode pdf-tools projectile rainbow-mode ox-reveal togetherly arduino-mode company-arduino org company-lsp cquery lsp-mode lsp-python dired-quick-sort try htmlize ledger-mode calfw calfw-org company doom-themes shm transpose-frame use-package yasnippet-snippets dired-ranger latex-preview-pane magit intero nyan-mode ace-jump-mode flymake-haskell-multi haskell-mode helm multiple-cursors expand-region flycheck powerline auto-complete))))
