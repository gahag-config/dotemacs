;(package-initialize)

;; Emacs ---------------------------------------------------------------------------------
(setq-default make-backup-files nil
              truncate-lines t ;; disable word-wrap.
              require-final-newline t

              tab-width 2
              tab-always-indent nil
              indent-tabs-mode  nil
              tab-stop-list (number-sequence 0 200 2)
              fill-column 90
              comment-column 0)

(fset 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region    'disabled nil)
(put 'downcase-region  'disabled nil)

(menu-bar-mode -1)
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(column-number-mode)

(delete-selection-mode)
(electric-pair-mode)
(show-paren-mode)
(global-auto-revert-mode t)

(global-unset-key "") ;; ESC ESC ESC

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-;"  ) 'comment-line)
(global-set-key (kbd "M-SPC") 'cycle-spacing)
(global-set-key (kbd "C-."  ) 'pop-tag-mark)

(set-register ?e '(file . "~/.emacs.d/init.el"))


;; Windmove ------------------------------------------------------------------------------
(windmove-default-keybindings 'meta)


;; Zap -----------------------------------------------------------------------------------
(require 'misc)

(global-set-key (kbd "M-z") 'zap-up-to-char)


;; Term ----------------------------------------------------------------------------------
(global-set-key (kbd "C-x t") 'term)


;; Tramp ---------------------------------------------------------------------------------
(setq-default tramp-terminal-type "tramp")


;; Dired ---------------------------------------------------------------------------------
(require 'dired)

(define-key dired-mode-map (kbd "K") 'dired-kill-subdir)
(define-key dired-mode-map (kbd "e") 'dired-toggle-read-only)

(setq-default dired-dwim-target t
              dired-listing-switches "-alhG1v --group-directories-first")


;; C-mode --------------------------------------------------------------------------------
(add-hook 'c-mode-hook 'c-toggle-comment-style)

(setq-default c-basic-offset 2
              c-default-style "stroustrup")

(c-set-offset 'substatement-open 0)


;; Bash ----------------------------------------------------------------------------------
(setq-default sh-basic-offset 2)


;; Python --------------------------------------------------------------------------------
(setq-default python-indent-offset 2
              python-guess-indent nil)


;; Defuns --------------------------------------------------------------------------------
(defun set-tab-size (size)
  "Set the tab size for the current buffer."
  
  (interactive "NSize: ") ;; Number

  (setq-local tab-stop-list (number-sequence 0 200 size))
  (let ((variables '(tab-width
                     c-basic-offset
                     haskell-indent-offset
                     python-indent-offset
                     sh-basic-offset
                     rust-indent-offset
                     web-mode-markup-indent-offset
                     css-indent-offset)))
    (mapc (lambda (var)
            (progn
              (make-local-variable var)
              (set var size)))
          variables)))


(defun align-whitespace (size)
  "Align columns delimited by whitespace."
  
  (interactive "NSize: ") ;; Number
  
  (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)\\s-" 1 size 't))


(defun find-temp-file (filename)
  "Find new temporary file"
  
  (interactive "sFile name: ") ;; String
  
  (find-file (make-temp-file filename)))


(defun shell-command-on-buffer ()
  (interactive)
  (shell-command-on-region (point-min)
                           (point-max)
                           (read-shell-command "Shell command on buffer: ")
                           (current-buffer)))


(defalias 'reload-local-variables 'hack-local-variables)
