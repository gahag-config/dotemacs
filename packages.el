;; Package setup -------------------------------------------------------------------------
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


;; Use-package ---------------------------------------------------------------------------
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; Powerline -----------------------------------------------------------------------------
(use-package powerline
  :ensure t
  :config (setq powerline-height 18
                powerline-default-separator 'slant))


;; Try -----------------------------------------------------------------------------------
(use-package try
  :ensure t)


;; Doom themes ---------------------------------------------------------------------------
(use-package doom-themes
  :ensure t
  :config (doom-themes-org-config))


;; Helm ----------------------------------------------------------------------------------
(use-package helm
  :ensure t
  :config
  (helm-mode)
  (setq helm-boring-buffer-regexp-list '("\\` "
                                         "\\`\\*helm"
                                         "\\`\\*Echo Area"
                                         "\\`\\*Minibuf"
                                         "\\`\\*EGLOT"
                                         "\\`\\*Flymake"
                                         "\\`magit.*:"))
  :bind
  (("M-x"     . helm-M-x)
   ("M-y"     . helm-show-kill-ring)
   ("C-x C-f" . helm-find-files)
   ("C-x C-b" . helm-mini)
   ("C-x b"   . helm-mini)))


;; Company -------------------------------------------------------------------------------
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode))


;; Yasnippet -----------------------------------------------------------------------------
(use-package yasnippet
  :ensure t
  :hook   (prog-mode . yas-global-mode))

(use-package yasnippet-snippets
  :ensure t
  :defer  t)

;; Flycheck ------------------------------------------------------------------------------
(use-package flycheck
  :ensure t
  :hook   (prog-mode . global-flycheck-mode)
  :config
  ; For some reason, the following does not work with setq, only with setq-default.
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq flycheck-global-modes '(not c-mode ; These are covered by eglot
                                    c++-mode
                                    rust-mode
                                    shell-mode
                                    ;; python-mode
                                    javascript-mode)))


;; Eglot ---------------------------------------------------------------------------------
(use-package eglot
  :ensure t
  :bind   (("C-c r" . eglot-rename)
           ("C-c h" . eglot-help-at-point))
  :hook   ((javascript-mode . eglot-ensure)
           (rust-mode       . eglot-ensure)
           (python-mode     . eglot-ensure)
           (shell-mode      . eglot-ensure)
           (c-mode          . eglot-ensure)
           (c++-mode        . eglot-ensure))
  :config
  (setq eglot-ignored-server-capabilites '(:documentHighlightProvider))
  (setq help-at-pt-timer-delay 0.3)
  (setq help-at-pt-display-when-idle '(flymake-diagnostic))
  (help-at-pt-set-timer))


;; Magit ---------------------------------------------------------------------------------
(use-package magit
  :ensure t
  :bind   ("C-x m" . magit-status)
  :config (setq magit-log-margin (quote (t
                                         "%Y-%m-%d %H:%M "
                                         magit-log-margin-width
                                         t
                                         10))))


;; Tramp ---------------------------------------------------------------------------------
(use-package tramp
  :ensure t
  :config (setq tramp-terminal-type "tramp")) ; Use specific terminal to prevent PS1
                                              ; parsing conflict.

;; Dired ---------------------------------------------------------------------------------
(use-package wdired ; This is necessary so the keybindings of dired-ranger won't be
  :ensure t         ; overriden by a late dired loading.
  :bind (:map dired-mode-map
              ("K" . dired-kill-subdir)))

(use-package dired-ranger
  :ensure t
  :bind (:map dired-mode-map
              ("C" . dired-ranger-copy)
              ("Y" . dired-ranger-paste)
              ("y" . dired-ranger-move)))

(use-package dired-quick-sort
  :ensure t
  :hook dired-mode
  :bind (:map dired-mode-map
              ("s" . hydra-dired-quick-sort/body)))


;; Org -----------------------------------------------------------------------------------
(use-package org
  :ensure t
  :bind (:map org-mode-map
              ;; These conflict with windmove:
              ("<M-up>"    . nil)
              ("<M-down>"  . nil)
              ("<M-left>"  . nil)
              ("<M-right>" . nil)
              ;; Expand region:
              ("C-," . nil)
              ("C-c a" . org-agenda))
  :config
  (setq org-todo-keywords '((sequence "TODO" "NEXT" "|" "DONE" "DISMISSED"))
        org-log-done 'time
        org-src-fontify-natively t
        org-tags-column 0
        org-agenda-tags-column 0
        org-html-head "<meta http-equiv='X-UA-Compatible' content='IE=edge'><meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'><style>html{touch-action:manipulation;-webkit-text-size-adjust:100%}body{padding:0;margin:0;background:#f2f6fa;color:#3c495a;font-weight:normal;font-size:15px;font-family:'San Francisco','Roboto','Arial',sans-serif}h2,h3,h4,h5,h6{font-family:'Trebuchet MS',Verdana,sans-serif;color:#586b82;padding:0;margin:20px 0 10px 0;font-size:1.1em}h2{margin:30px 0 10px 0;font-size:1.2em}a{color:#3fa7ba;text-decoration:none}p{margin:6px 0;text-align:justify}ul,ol{margin:0;text-align:justify}ul>li>code{color:#586b82}pre{white-space:pre-wrap}#content{width:96%;max-width:1000px;margin:2% auto 6% auto;background:white;border-radius:2px;border-right:1px solid #e2e9f0;border-bottom:2px solid #e2e9f0;padding:0 115px 150px 115px;box-sizing:border-box}#postamble{display:none}h1.title{background-color:#343C44;color:#fff;margin:0 -115px;padding:60px 0;font-weight:normal;font-size:2em;border-top-left-radius:2px;border-top-right-radius:2px}@media (max-width: 1050px){#content{padding:0 70px 100px 70px}h1.title{margin:0 -70px}}@media (max-width: 800px){#content{width:100%;margin-top:0;margin-bottom:0;padding:0 4% 60px 4%}h1.title{margin:0 -5%;padding:40px 5%}}pre,.verse{box-shadow:none;background-color:#f9fbfd;border:1px solid #e2e9f0;color:#586b82;padding:10px;font-family:monospace;overflow:auto;margin:6px 0}#table-of-contents{margin-bottom:50px;margin-top:50px}#table-of-contents h2{margin-bottom:5px}#text-table-of-contents ul{padding-left:15px}#text-table-of-contents>ul{padding-left:0}#text-table-of-contents li{list-style-type:none}#text-table-of-contents a{color:#7c8ca1;font-size:0.95em;text-decoration:none}table{border-color:#586b82;font-size:0.95em}table thead{color:#586b82}table tbody tr:nth-child(even){background:#f9f9f9}table tbody tr:hover{background:#586b82!important;color:white}table .left{text-align:left}table .right{text-align:right}.todo{font-family:inherit;color:inherit}.done{color:inherit}.tag{background:initial}.tag>span{background-color:#eee;font-family:monospace;padding-left:7px;padding-right:7px;border-radius:2px;float:right;margin-left:5px}#text-table-of-contents .tag>span{float:none;margin-left:0}.timestamp{color:#7c8ca1}@media print{@page{margin-bottom:3cm;margin-top:3cm;margin-left:2cm;margin-right:2cm;font-size:10px}#content{border:none}}</style>"
        org-export-with-toc nil
        org-export-with-planning t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t))))

(use-package calfw
  :ensure t
  :after  org)

(use-package calfw-org
  :ensure t
  :after  calfw
  :config (setq cfw:org-overwrite-default-keybinding t))


;; Pdf-tools -----------------------------------------------------------------------------
(use-package pdf-tools
  :ensure t
  :defer  t
  :magic  ("%PDF" . pdf-view-mode)
  :config (pdf-tools-install))

;; Latex ---------------------------------------------------------------------------------
(use-package latex-preview-pane
  :defer t
  :config (setq shell-escape-mode "-shell-escape"))


;; Bash ----------------------------------------------------------------------------------
(use-package sh-script
  :ensure t
  :defer  t
  :config (setq sh-basic-offset 2))


;; Javscript -----------------------------------------------------------------------------
(use-package js
  :ensure t
  :defer  t
  :config (setq js-indent-level 2))


;; Python---------------------------------------------------------------------------------
(use-package python
  :ensure t
  :defer  t
  :config (setq python-indent-offset 2
                python-guess-indent nil))

(use-package elpy
  :ensure t
  :after  python
  :config (elpy-enable)
  :bind (:map elpy-mode-map
              ;; These conflict with windmove:
              ("<M-up>"    . nil)
              ("<M-down>"  . nil)
              ("<M-left>"  . nil)
              ("<M-right>" . nil)
              ;; Conflict with ace-jump:
              ("C-x g" . nil)))


;; Haskell -------------------------------------------------------------------------------
(use-package haskell-mode
  :defer t
  :config
  (setq haskell-indent-offset 2
        haskell-font-lock-symbols t)
  
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent) ; Replace by structured-haskell-mode.
  
  (eval-after-load 'haskell-font-lock
    '(progn
       (defconst haskell-font-lock-symbols-alist
                 '(("\\" . "λ") ("." "∘" haskell-font-lock-dot-is-not-composition)))
       ;; (setq haskell-font-lock-keywords (haskell-font-lock-keywords-create nil))
       )))
  
(use-package intero
  :ensure t
  :hook (haskell-mode . intero-mode))

;; (use-package shm
;;   :ensure t
;;   :hook (haskell-mode . structured-haskell-mode))


;; Markdown ------------------------------------------------------------------------------
(use-package markdown-mode
  :bind (:map markdown-mode-map
              ;; These conflict with windmove:
              ("<M-up>"    . nil)
              ("<M-down>"  . nil)
              ("<M-left>"  . nil)
              ("<M-right>" . nil)))


;; Expand region -------------------------------------------------------------------------
(use-package expand-region
  :ensure t
  :bind   ("C-," . er/expand-region)
  :config (setq expand-region-contract-fast-key "."))


;; Ace jump ------------------------------------------------------------------------------
(use-package ace-jump-mode
  :ensure t
  :bind ("C-x g" . ace-jump-mode))


;; Multiple cursors ----------------------------------------------------------------------
(use-package multiple-cursors
  :ensure t
  :bind
  (("M-p"     . mc/mark-previous-lines)
   ("M-n"     . mc/mark-next-lines)
   ("C-x C-n" . mc/mark-next-like-this)))


;; Misc ----------------------------------------------------------------------------------
(use-package misc
  :bind ("M-z" . zap-up-to-char))


;; Transpose frame -----------------------------------------------------------------------
(use-package transpose-frame
  :ensure t
  :bind   ("C-x |" . transpose-frame))


;; Ledger --------------------------------------------------------------------------------
(use-package ledger-mode
  :ensure t
  :mode "\\.ledger\\'"
  :bind (:map ledger-mode-map
              ("C-c a" . ledger-add-transaction)
              ("C-c r" . ledger-report)
              ("M-p"   . nil)
              ("M-n"   . nil)
              ("C-M-p" . ledger-navigate-prev-xact-or-directive)
              ("C-M-n" . ledger-navigate-next-xact-or-directive))
  :config
  (setq ledger-reports  ; All default, but removing income from report.
        '(("bal"     "%(binary) -f %(ledger-file) bal not income")
          ("reg"     "%(binary) -f %(ledger-file) reg not income")
          ("payee"   "%(binary) -f %(ledger-file) reg @%(payee) not income")
          ("account" "%(binary) -f %(ledger-file) reg %(account) not income"))))


;; ---------------------------------------------------------------------------------------
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
