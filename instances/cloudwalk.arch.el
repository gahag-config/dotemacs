;(package-initialize)

(require 'xdg)

(defconst desktop-home  (concat (xdg-data-home) "/emacs/desktops/"))
(defconst dotemacs-dir  "/home/gahag/gahag/config/dotemacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files '("/home/gahag/gahag/org"))

;; features:
(defconst package-features '(feature-lsp
                             feature-pdftools
                             feature-python
                             feature-rust
                             feature-yaml
                             feature-docker
                             feature-org-reveal
                             feature-plantuml
                             feature-org-presentation
                             feature-org-calc
                             feature-restclient
                             feature-verb))

(load dotemacs-file)

(load-X-theme 'doom-gahag-light)
(powerline-gahag-light-theme)


(add-hook 'rust-mode-hook
          (lambda ()
            (progn
              (set-indent-size 4 nil)
              (indent-spaces-mode))))


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
 '(auth-source-save-behavior nil)
 '(package-selected-packages
   '(plantuml-mode ron-mode rust-playground ob-rust nginx-mode go-mode verb org-tree-slide web-mode literate-calc-mode pdf-tools olivetti js2-mode yasnippet-snippets ob-restclient php-mode restclient vterm use-package cmake-mode org-chef org org-re-reveal rg rust-mode org-ref multi-line csharp-mode ccls diminish dired-narrow dired-subtree multi-term org-bullets docker csv yaml-mode helm intero multiple-cursors lsp-java lsp-mode lsp-ui magit powerline yasnippet wgrep ein dockerfile-mode json-mode lua-mode use-package-ensure-system-package gradle-mode highlight-indent-guides pcap-mode lsp-rust csv-mode jsx-mode rainbow-mode ox-reveal togetherly arduino-mode company-arduino cquery lsp-python dired-quick-sort try ledger-mode calfw calfw-org company doom-themes shm transpose-frame dired-ranger latex-preview-pane nyan-mode ace-jump-mode flymake-haskell-multi haskell-mode expand-region flycheck auto-complete)))
