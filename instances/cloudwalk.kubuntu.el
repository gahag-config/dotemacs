;(package-initialize)

(require 'xdg)

; I hate snaps
(setenv "XDG_DATA_DIRS" (replace-regexp-in-string "/snap/emacs/2504/usr/share:" "" (getenv "XDG_DATA_DIRS")))

(defconst desktop-home  (concat (xdg-data-home) "/emacs/desktops/"))
(defconst dotemacs-dir  "/home/gabriel_bastos/gahag/config/dotemacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq-default org-agenda-files '("/home/gabriel_bastos/gahag/org"))

;; features:
(defconst package-features '(feature-lsp
                             feature-llm
                             feature-pdftools
                             feature-python
                             feature-ruby
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

(setq org-plantuml-jar-path "~/.local/bin/plantuml.jar")
(setq plantuml-jar-path "~/.local/bin/plantuml.jar")

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
   '(ace-jump-mode adaptive-wrap arduino-mode auto-complete calfw calfw-org ccls cmake-mode
                   company company-arduino cquery csharp-mode csv csv-mode dart-mode
                   diminish dired-narrow dired-quick-sort dired-ranger dired-subtree
                   docker dockerfile-mode doom-themes ein elixir-mode elysium
                   expand-region flycheck flymake-haskell-multi go-mode gptel gradle-mode
                   graphviz-dot-mode haskell-mode helm highlight-indent-guides intero
                   js2-mode json-mode jsx-mode kotlin-mode latex-preview-pane ledger-mode
                   literate-calc-mode lsp-java lsp-mode lsp-python lsp-rust lsp-ui
                   lua-mode magit multi-line multi-term multiple-cursors nginx-mode
                   nyan-mode ob-restclient ob-rust olivetti org org-bullets org-chef
                   org-re-reveal org-ref org-tree-slide ox-reveal pcap-mode pdf-tools
                   php-mode plantuml-mode powerline rainbow-mode restclient rg ron-mode
                   rust-mode rust-playground shm swift-mode terraform-mode togetherly
                   transpose-frame try use-package use-package-ensure-system-package verb
                   vterm web-mode wgrep yaml-mode yasnippet yasnippet-snippets))
 '(safe-local-variable-values '((gptel-org-branching-context . t))))
