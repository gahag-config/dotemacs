;; Emacs
(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings 'meta)

(setq-default make-backup-files nil)
(setq-default x-select-enable-clipboard t)
(set-default 'truncate-lines t)

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region    'disabled nil)
(put 'downcase-region  'disabled nil)

;; Cursor
(setq-default cursor-type 'bar)
(set-cursor-color "WhiteSmoke")

;; Indent
(setq-default tab-width 2)
(setq-default tab-always-indent nil)
(setq-default indent-tabs-mode  nil)
(setq-default tab-stop-list (number-sequence 0 200 2))

;; Company
(setq-default company-idle-delay t)

;; C style
(setq-default c-default-style "c#")
(setq-default c-basic-offset 2)
(c-set-offset 'substatement-open 0)

;; Haskell style
(setq-default haskell-font-lock-symbols t)
(setq-default haskell-indent-offset 2)
(setq-default haskell-mode-hook 'turn-on-haskell-indent)

;; Python style
(setq-default python-indent-offset 2)

;; Shell style
(setq-default sh-basic-offset 2)

;; Css style
(setq-default css-indent-offset 2)

;; Org
(setq org-log-done 'note)
(setq org-src-fontify-natively t)

;; DocView
(setq doc-view-continuous t)

;; Recentf
(setq recentf-save-file       "~/.emacs.d/.cache/recent-files"
      recentf-max-saved-items 50
      recentf-max-menu-items  15)
