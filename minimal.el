;(package-initialize)

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


;; Visual --------------------------------------------------------------------------------
(if window-system
    (progn (tool-bar-mode -1)
           (scroll-bar-mode -1)))
(menu-bar-mode -1)
(column-number-mode)
;; (global-display-line-numbers-mode) ; (global-linum-mode)


;; Behavior ------------------------------------------------------------------------------
(delete-selection-mode)
(electric-pair-mode)
(show-paren-mode)
(global-auto-revert-mode t)


;; keys ----------------------------------------------------------------------------------
(global-unset-key "") ;; ESC ESC ESC

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-;"  ) 'comment-line)
(global-set-key (kbd "M-SPC") 'cycle-spacing)
(global-set-key (kbd "C-."  ) 'pop-tag-mark)
(global-set-key (kbd "M-z"  ) 'zap-up-to-char)

(global-set-key (kbd "C-x t") 'term)


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


;; Js
(setq-default js-indent-level 2)


;; Sh
(setq-default sh-basic-offset 2)


;; Modes ---------------------------------------------------------------------------------

;; DocView
(setq-default doc-view-continuous t)


;; Dired
(require 'dired)
(setq-default dired-dwim-target t
              dired-listing-switches "-alhG1v --group-directories-first")
(define-key dired-mode-map (kbd "K") 'dired-kill-subdir)
(define-key dired-mode-map (kbd "e") 'dired-toggle-read-only)


;; Tramp
(setq-default tramp-terminal-type "tramp")


;; indent --------------------------------------------------------------------------------
(defun set-tab-size (size)
  "Set the tab size for the current buffer."
  
  (interactive "NSize: ") ;; Number
  
  (setq-local tab-width size)
  (setq-local tab-stop-list (number-sequence 0 200 size))
  (setq-local c-basic-offset size)
  (setq-local haskell-indent-offset size))


(defun align-whitespace (size)
  "Align columns delimited by whitespace."
  
  (interactive "NSize: ") ;; Number
  
  (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)\\s-" 1 size 't))


;; etc -----------------------------------------------------------------------------------
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR."
  'interactive)


(defun find-temp-file (filename)
  "Find new temporary file"
  
  (interactive "sFile name: ") ;; String
  
  (find-file (make-temp-file filename)))


(defalias 'open 'browse-url-of-buffer)


(set-register ?e '(file . "~/.emacs"))


;; Theming -------------------------------------------------------------------------------
(defadvice load-theme (before clear-previous-themes activate)
  "Clear existing theme settings instead of layering them."
  (mapc #'disable-theme custom-enabled-themes))


(defun load-X-theme (theme)
  "Load theme when not in a terminal."
  (if (display-graphic-p)
      (load-theme theme t)))
