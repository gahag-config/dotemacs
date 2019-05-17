;; -*- byte-compile-warnings: (not free-vars); -*-
;; Package setup -------------------------------------------------------------------------
(require 'package)

(setq-default package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                                 ("org" . "https://orgmode.org/elpa/")
                                 ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


;; Features ------------------------------------------------------------------------------
(if (boundp 'package-features)
    (mapc (lambda (feature) (set feature t))
          package-features))

(defmacro package-feature (feat code)
  `(when (boundp ,feat)
         ,code))


;; Use-package ---------------------------------------------------------------------------
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; Powerline -----------------------------------------------------------------------------
(use-package powerline
  :ensure t
  :config (setq powerline-height 18
                powerline-default-separator 'slant))


;; Doom themes ---------------------------------------------------------------------------
(use-package doom-themes
  :ensure t
  :config (doom-themes-org-config))


;; Rg ------------------------------------------------------------------------------------
(use-package rg
  :ensure t
  :commands rg
  :bind (:map rg-mode-map
              ("n" . rg-next-file)
              ("p" . rg-prev-file)))


;; Helm ----------------------------------------------------------------------------------
(use-package helm
  :ensure t
  :config
  (helm-mode)
  (setq helm-buffer-skip-remote-checking t ; Prevent helm-mini from querying remote buffers
        helm-boring-buffer-regexp-list '("\\` "
                                         "\\`\\*helm"
                                         "\\`\\*Echo Area"
                                         "\\`\\*Minibuf"
                                         "\\`\\*lsp-log\\*"
                                         "\\`\\*\\(\\w\\|-\\)+ls\\(::stderr\\)?\\*\\'"
                                         "\\`\\*cquery\\(::stderr\\)?\\*\\'"
                                         ;; "\\`\\*EGLOT"
                                         "\\`\\*Flymake"
                                         "\\`\\*Flycheck"
                                         "\\`magit.*:"
                                         "\\`\\*tramp"
                                         "\\`\\*ein:jupyter-server\\*"
                                         "\\`\\*ein:log-all\\*"
                                         "\\`\\*ein:.*\\*\\[markdown\\]"
                                         "\\`\\*ein:.*\\*\\[python\\]"))
  :bind
  (("M-x"     . helm-M-x)
   ("M-y"     . helm-show-kill-ring)
   ("C-x C-f" . helm-find-files)
   ("C-x C-b" . helm-mini)
   ("C-x b"   . helm-mini)))


;; Company -------------------------------------------------------------------------------
(use-package company
  :ensure t
  :defer t
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode))


;; Yasnippet -----------------------------------------------------------------------------
(use-package yasnippet
  :ensure t
  :defer t
  :hook   (prog-mode . yas-global-mode))

(use-package yasnippet-snippets
  :ensure t
  :defer  t)

;; Flycheck ------------------------------------------------------------------------------
(use-package flycheck
  :ensure t
  :defer t
  :hook   (prog-mode . flycheck-mode)
  :config
  ; For some reason, the following does not work with setq, only with setq-default.
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))


;; Lsp -----------------------------------------------------------------------------------
;; (use-package eglot
;;   :ensure t
;;   :bind   (("C-c r" . eglot-rename)
;;            ("C-c h" . eglot-help-at-point))
;;   :hook   ((javascript-mode . eglot-ensure)
;;            (rust-mode       . eglot-ensure)
;;            (python-mode     . eglot-ensure)
;;            (shell-mode      . eglot-ensure)
;;            (c-mode          . eglot-ensure)
;;            (c++-mode        . eglot-ensure))
;;   :config
;;   (setq help-at-pt-timer-delay 0.3
;;         help-at-pt-display-when-idle '(flymake-diagnostic)
;;         eglot-ignored-server-capabilites '(:documentHighlightProvider))
;;   (help-at-pt-set-timer))

(package-feature 'feature-lsp
  (use-package lsp-mode
    :ensure t
    :commands lsp
    :bind (:map lsp-mode-map
                ("C-c r" . lsp-rename)
                ("C-c h" . lsp-describe-thing-at-point)
                ("C-c a" . lsp-execute-code-action))
    :config
    (setq-default lsp-prefer-flymake nil)))

(package-feature 'feature-lsp
  (use-package lsp-ui
    :ensure t
    :defer t
    :commands lsp-ui-mode
    :bind (:map lsp-ui-mode-map
                ("C-M-." . lsp-ui-peek-find-references)
                ("M-."   . lsp-ui-peek-find-definitions))
    :config
    (setq lsp-ui-sideline-ignore-duplicate t
          lsp-ui-peek-always-show t
          lsp-ui-doc-enable nil)))

(package-feature 'feature-lsp
  (use-package company-lsp
    :ensure t
    :defer t
    :commands company-lsp
    :config
    (setq company-lsp-async t
          company-lsp-enable-snippet t)))


;; Magit ---------------------------------------------------------------------------------
(use-package magit
  :ensure t
  :defer t
  :bind   ("C-x m" . magit-status)
  :bind   (:map magit-file-mode-map
                ("C-x g" . nil))
  :config (setq-default magit-diff-refine-hunk 'all)
          (setq magit-log-margin (quote (t
                                         "%Y-%m-%d %H:%M "
                                         magit-log-margin-width
                                         t
                                         10)))
          (setq magit-git-global-arguments ; magit over tramp
                (nconc magit-git-global-arguments
                       '("-c" "color.ui=false"
                         "-c" "color.diff=false"))))


;; Ediff ---------------------------------------------------------------------------------
(use-package ediff
  :ensure t
  :defer t
  :config (setq ediff-window-setup-function 'ediff-setup-windows-plain
                ediff-split-window-function 'split-window-horizontally))


;; Tramp ---------------------------------------------------------------------------------
(use-package tramp
  :ensure t
  :defer t
  :config (setq tramp-terminal-type "tramp")) ; Use specific terminal to prevent PS1
                                              ; parsing conflict.

;; Dired ---------------------------------------------------------------------------------
(use-package wdired
  :ensure t
  ; This is necessary so the keybindings of dired-ranger won't be overriden by a late
  ; dired loading:
  :demand t
  :config (setq delete-by-moving-to-trash t)
  :bind (:map dired-mode-map
              ("K" . dired-kill-subdir)
              ("e" . dired-toggle-read-only)))

(use-package dired-ranger
  :ensure t
  :defer t
  :bind (:map dired-mode-map
              ("c" . dired-ranger-copy)
              ("Y" . dired-ranger-paste)
              ("y" . dired-ranger-move)))

(use-package dired-quick-sort
  :ensure t
  :defer t
  :hook dired-mode
  :bind (:map dired-mode-map
              ("s" . hydra-dired-quick-sort/body)))


;; Org -----------------------------------------------------------------------------------
(use-package org
  :ensure t
  :pin org
  :hook (org-babel-after-execute . (lambda () (when org-inline-image-overlays
                                                (org-redisplay-inline-images))))
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
  (mapc (lambda (arg) (setcdr arg (list (downcase (cadr arg))))) ; lowercase structure templates
    org-structure-template-alist)

  (setq org-todo-keywords '((sequence "TODO" "NEXT" "|" "DONE" "DISMISSED"))
        org-list-allow-alphabetical t
        org-log-done 'time
        org-tags-column 0
        org-agenda-tags-column 0
        org-export-with-toc nil
        org-export-with-planning t
        org-src-tab-acts-natively t
        org-src-fontify-natively t
        org-src-window-setup 'current-window

        ;; Minted setup:
        org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-minted-options '(("fontsize" "\\small"))
        org-latex-pdf-process
         '("latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode -output-directory %o' -pdf -f  %f"))

  (setq org-agenda-custom-commands
        '(("1" "Week schedule" agenda "display scheduled and deadlines for the current week"
           ((org-agenda-span 'week)
            (org-agenda-time-grid nil)
            (org-agenda-show-all-dates nil)
            (org-agenda-entry-types '(:deadline :scheduled))
            (org-deadline-warning-days 0)))
          ("2" "Month schedule" agenda "display scheduled and deadlines for the current month"
           ((org-agenda-span 'month)
            (org-agenda-time-grid nil)
            (org-agenda-show-all-dates nil)
            (org-agenda-entry-types '(:deadline :scheduled))
            (org-deadline-warning-days 0)))
          ))
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t)))

  (put 'org-html-htmlize-output-type 'safe-local-variable (lambda (_) t))
  (put 'org-table-convert-region-max-lines 'safe-local-variable (lambda (_) t)))


(use-package calfw
  :ensure t
  :defer t
  :after org)

(use-package calfw-org
  :ensure t
  :defer t
  :after calfw
  :config (setq cfw:org-overwrite-default-keybinding t))

;; (use-package ox-reveal ; TODO: replace with org-re-reveal or emacs-reveal
;;   :ensure t
;;   :after  org
;;   :config
;;   (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/"))


;; Pdf-tools -----------------------------------------------------------------------------
(package-feature 'feature-pdftools
  (use-package pdf-tools
    :ensure t
    :defer  t
    :magic  ("%PDF" . pdf-view-mode)
    :config (pdf-tools-install)))


;; C-mode --------------------------------------------------------------------------------
(package-feature 'feature-lsp-c
  (use-package cquery
    :ensure t
    :defer t
    :hook ((c-mode   . (lambda () (require 'cquery) (lsp)))
           (c++-mode . (lambda () (require 'cquery) (lsp))))))


;; Bash ----------------------------------------------------------------------------------
(use-package sh-script
  :ensure t
  :defer  t
  :config (setq sh-basic-offset 2))


;; Javascript ----------------------------------------------------------------------------
(package-feature 'feature-javascript
  (use-package js2-mode
    :ensure t
    :defer  t
    :mode "\\.js\\'"
    :hook (js2-mode . lsp)
    :config (setq js-indent-level 2)))


;; Java ----------------------------------------------------------------------------------
(package-feature 'feature-lsp-java
  (use-package lsp-java
    :ensure t
    :defer t
    :hook (java-mode . (lambda () (require 'lsp-java) (lsp)))
    :config
    (setq lsp-java-server-install-dir "/usr/share/java/jdtls/"
          lsp-java-workspace-dir (concat (getenv "XDG_CACHE_HOME") "/eclipse-workspace/"))))


;; Python --------------------------------------------------------------------------------
(package-feature 'feature-python
  (use-package python
    :ensure t
    :defer  t
    :hook (python-mode . lsp)
    :config (setq python-indent-offset 2
                  python-guess-indent nil)))


;; Jupyter -------------------------------------------------------------------------------
(package-feature 'feature-ein
 (use-package ein
   :ensure t
   :defer t
   :config
   (setq ein:polymode t)))  ; inline images and some other stuff.


;; Rust ----------------------------------------------------------------------------------
(package-feature 'feature-rust
  (use-package rust-mode
    :ensure t
    :defer  t
    :hook (rust-mode . lsp)
    :config (setq-default rust-indent-offset 2)))


;; Haskell -------------------------------------------------------------------------------
(package-feature 'feature-haskell
  (use-package haskell-mode
    :ensure t
    :defer t
    :hook (haskell-mode . turn-on-haskell-indent) ; Replace by structured-haskell-mode.
    :config
    (setq haskell-indent-offset 2
          haskell-font-lock-symbols t)
    
    (eval-after-load 'haskell-font-lock
      '(progn
         (defconst haskell-font-lock-symbols-alist
           '(("\\" . "λ") ("." "∘" haskell-font-lock-dot-is-not-composition)))
         ;; (setq haskell-font-lock-keywords (haskell-font-lock-keywords-create nil))
         ))))
  
(package-feature 'feature-haskell
  (use-package intero
    :ensure t
    :defer t
    :hook (haskell-mode . intero-mode)))

;; (use-package shm
;;   :ensure t
;;   :hook (haskell-mode . structured-haskell-mode))


;; Lua -----------------------------------------------------------------------------------
(package-feature 'feature-lua
  (use-package lua-mode
    :ensure t
    :defer t
    :hook (lua-mode . lsp)
    :config
    (setq lua-indent-level 2)))

(package-feature 'feature-lsp-lua
  (use-package lsp-lua
    :after lsp
    :init (provide 'lsp-lua)
    :config
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection "lua-lsp")
                      :major-modes '(lua-mode)
                      :server-id 'lua-ls))
    (setq lsp-prefer-flymake nil)))


;; HTML ----------------------------------------------------------------------------------
(use-package web-mode
  :ensure t
  :defer t
  :mode ("\\.html\\'")
  :bind (:map web-mode-map
              ("C-c C-c" . web-mode-element-close)
              ("C-c C-n" . web-mode-tag-next)
              ("C-c C-p" . web-mode-tag-previous)
              ("C-<tab>" . web-mode-fold-or-unfold))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-enable-current-element-highlight t))


;; Markdown ------------------------------------------------------------------------------
(use-package markdown-mode
  :ensure t
  :defer t
  :bind (:map markdown-mode-map
              ;; These conflict with windmove:
              ("<M-up>"    . nil)
              ("<M-down>"  . nil)
              ("<M-left>"  . nil)
              ("<M-right>" . nil)))


;; Json ----------------------------------------------------------------------------------
(use-package json-mode
  :ensure t
  :defer t)


;; Dockerfile ----------------------------------------------------------------------------
(package-feature 'feature-docker
  (use-package dockerfile-mode
    :ensure t
    :defer t))


;; Highlight Indent Guides ---------------------------------------------------------------
(use-package highlight-indent-guides
  :ensure t
  :defer t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-responsive 'top))


;; Expand region -------------------------------------------------------------------------
(use-package expand-region
  :ensure t
  :defer t
  :bind ("C-," . er/expand-region)
  :config (setq expand-region-contract-fast-key "."))


;; Ace jump ------------------------------------------------------------------------------
(use-package ace-jump-mode
  :ensure t
  :defer t
  :bind ("C-x g" . ace-jump-mode))


;; Multiple cursors ----------------------------------------------------------------------
(use-package multiple-cursors
  :ensure t
  :defer t
  :bind
  (("M-p"     . mc/mark-previous-lines)
   ("M-n"     . mc/mark-next-lines)
   ("C-x C-n" . mc/mark-next-like-this)))


;; Misc ----------------------------------------------------------------------------------
(use-package misc
  :defer t
  :bind ("M-z" . zap-up-to-char))


;; Transpose frame -----------------------------------------------------------------------
(use-package transpose-frame
  :ensure t
  :defer t
  :bind   ("C-x |" . transpose-frame))


;; Ledger --------------------------------------------------------------------------------
(package-feature 'feature-ledger
  (use-package ledger-mode
    :ensure t
    :defer t
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
          '(("bal"     "ledger -f %(ledger-file) bal")
            ("reg"     "ledger -f %(ledger-file) reg")
            ("account" "ledger -f %(ledger-file) reg %(account)")))))


;; Togetherly ----------------------------------------------------------------------------
(package-feature 'feature-togetherly
  (use-package togetherly
    :ensure t
    :defer t))


;; ---------------------------------------------------------------------------------------
