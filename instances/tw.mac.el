;(package-initialize)

(require 'xdg)

(defconst desktop-home  (concat (xdg-data-home) "/emacs/desktops/"))
(defconst dotemacs-dir  "~/tw/config/dotemacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files '("~/tw/org"))

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
                             feature-restclient))

(load dotemacs-file)

(setq dired-listing-switches "-alhGv")
(add-to-list 'exec-path "/usr/local/bin/")

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(load-X-theme 'doom-gahag-light)
(powerline-gahag-light-theme)

;; ---------------------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(exec-path-from-shell ob-restclient restclient ledger-mode transpose-frame multiple-cursors ace-jump-mode multi-line expand-region highlight-indent-guides docker dockerfile-mode json-mode web-mode rust-mode literate-calc-mode org-tree-slide olivetti org-re-reveal org-ref calfw-org calfw org-bullets dired-subtree dired-narrow dired-quick-sort dired-ranger vterm magit lsp-ui lsp-mode flycheck yasnippet-snippets yasnippet rg company helm doom-themes diminish powerline use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 125 :width normal)))))
