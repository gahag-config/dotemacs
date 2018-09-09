;; Emacs ---------------------------------------------------------------------------------
(setq-default make-backup-files nil
              x-select-enable-clipboard t
              truncate-lines t ;; disable word-wrap.
              require-final-newline t)


(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings 'meta)


(put 'narrow-to-region 'disabled nil)
(put 'upcase-region    'disabled nil)
(put 'downcase-region  'disabled nil)


;; Style ---------------------------------------------------------------------------------
(setq-default tab-width 2
              tab-always-indent nil
              indent-tabs-mode  nil
              tab-stop-list (number-sequence 0 200 2)
              fill-column 90
              comment-column 0)


;; C
(setq-default c-basic-offset 2
              c-default-style "stroustrup")

(c-set-offset 'substatement-open 0)

(add-hook 'c-mode-hook (lambda () (c-toggle-comment-style -1)))


;; Css
(setq-default css-indent-offset 2)


;; Modes ---------------------------------------------------------------------------------

;; DocView
(setq-default doc-view-continuous t)


;; Dired
(setq-default dired-dwim-target t
              dired-listing-switches "-alhG1v --group-directories-first")


;; Recentf
(setq-default recentf-save-file       "~/.emacs.d/.cache/recent-files"
              recentf-max-saved-items 50
              recentf-max-menu-items  15)
