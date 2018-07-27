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
  :config (helm-mode)
  :bind
  (("M-x"     . helm-M-x)
   ("M-y"     . helm-show-kill-ring)
   ("C-x C-f" . helm-find-files)
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
  (setq org-log-done 'time
        org-src-fontify-natively t
        org-tags-column 0
        org-agenda-tags-column 0
        org-todo-keywords '((sequence "TODO" "NEXT" "|" "DONE" "DISMISSED")))
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
