;(package-initialize)

(require 'xdg)

(defconst desktop-home  (concat (xdg-data-home) "/emacs/desktops/"))
(defconst dotemacs-dir  "/gahag/config/emacs/dotemacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files
              (append
               (file-expand-wildcards "/gahag/org/*.org")
               (file-expand-wildcards "/gahag/org/work/*.org")
               (file-expand-wildcards "/gahag/org/gastro/*.org")
               (file-expand-wildcards "/gahag/org/cinema/*.org")))

;; features:
(defconst package-features '(feature-lsp
                             feature-pdftools
                             feature-rust
                             feature-ledger
                             feature-org-paper
                             feature-org-reveal
                             feature-org-presentation
                             feature-org-calc
                             feature-docker
                             feature-javascript
                             feature-restclient))


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
 '(auth-source-save-behavior nil)
 '(package-selected-packages
   '(ob-restclient scala-mode weblorg gnuplot org-re-reveal js2-mode restclient org-ref literate-calc-mode org-tree-slide olivetti htmlize vterm sml-mode multi-line yasnippet-snippets yasnippet pdf-tools rust-mode web-mode docker org-bullets lsp-mode diminish lsp-ui magit multi-term rainbow-mode ccls dired-narrow dired-subtree use-package lsp-java rg dockerfile-mode json-mode lua-mode use-package-ensure-system-package highlight-indent-guides wakatime-mode diff-hl company-lsp cquery lsp-python org togetherly dired-quick-sort dired-ranger ledger-mode try csharp-mode flycheck markdown-mode transpose-frame calfw-org calfw csv-mode rainbow-delimiters gruvbox-theme doom-themes flymd flycheck-haskell yaml-mode impatient-mode latex-preview-pane intero lorem-ipsum gh-md markdown-preview-mode powerline omnisharp multiple-cursors heroku-theme helm haskell-mode fsharp-mode flatui-theme expand-region elm-mode company ace-jump-mode)))
