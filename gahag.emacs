(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

;; ---------------------------------------------------------------------------------------

(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR.
  
  \(fn arg char)"
    'interactive)

;; ---------------------------------------------------------------------------------------

(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings 'meta)

(setq-default make-backup-files nil)
(setq-default x-select-enable-clipboard t)
(set-default 'truncate-lines t)

(setq recentf-save-file       "~/.emacs.d/.cache/recent-files"
      recentf-max-saved-items 50
      recentf-max-menu-items  15)

(setq-default cursor-type 'bar)
(set-cursor-color "WhiteSmoke")

(setq-default tab-width 2)
(setq-default tab-always-indent nil)
(setq-default indent-tabs-mode  nil)
(setq-default tab-stop-list (number-sequence 0 200 2))


(setq-default c-default-style "c#")
(setq-default c-basic-offset 2)
(c-set-offset 'substatement-open 0)

(setq-default haskell-font-lock-symbols t)
(setq-default haskell-indent-offset 2)
(setq-default haskell-mode-hook (quote (turn-on-haskell-indent)))

(setq org-log-done 'note)

;; ---------------------------------------------------------------------------------------

(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda () (if (not (minibufferp (current-buffer)))
                                  (auto-complete-mode 1))))


(global-linum-mode)
(powerline-center-theme)
(column-number-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)

(real-global-auto-complete-mode)
(global-flycheck-mode)
(yas-global-mode)
(semantic-mode)
(electric-pair-mode)

(delete-selection-mode)
(show-paren-mode)

(helm-mode)
;;(projectile-global-mode)
(recentf-mode t)
(desktop-save-mode t)
(global-auto-revert-mode t)

;; ---------------------------------------------------------------------------------------

(set-register ?e '(file . "~/.emacs"))

(global-unset-key "")

(global-set-key "\M-x"     'helm-M-x)
(global-set-key "\M-y"     'helm-show-kill-ring)
(global-set-key "\C-x\C-f" 'helm-find-files)
(global-set-key "\C-xb"    'helm-mini)

(setq expand-region-contract-fast-key ".")
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key "\C-xg"     'ace-jump-mode)
(global-set-key "\M-z"      'zap-up-to-char)
(global-set-key "\M-p"      'mc/mark-previous-lines)
(global-set-key "\M-n"      'mc/mark-next-lines)
(global-set-key "\C-x\C-n"  'mc/mark-next-like-this)
(global-set-key "\C-xk"     'kill-this-buffer)
(global-set-key "\M- "      'cycle-spacing)

(define-key org-mode-map (kbd "<M-up>")    nil)
(define-key org-mode-map (kbd "<M-down>")  nil)
(define-key org-mode-map (kbd "<M-left>")  nil)
(define-key org-mode-map (kbd "<M-right>") nil) 
;; ---------------------------------------------------------------------------------------

(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-language-standard "c++14")))
(add-hook 'c-mode-hook
          (lambda ()
                  (setq flycheck-gcc-language-standard "c99"
                        comment-start "//"
                        comment-end   ""                     )))


(add-hook 'term-mode-hook
          '(lambda () (term-set-escape-char ?\C-x)))


(eval-after-load 'haskell-font-lock
 '(progn (defconst haskell-font-lock-symbols-alist
                   '(("\\" . "λ") ("." "∘" haskell-font-lock-dot-is-not-composition)))
         (setq haskell-font-lock-keywords (haskell-font-lock-keywords-create nil))))

;; ---------------------------------------------------------------------------------------

(defun create-tags (dir-name)
  "Create tags file."
  
  (interactive "DDirectory: ")  ; Directory
  
  (let ((dir (directory-file-name dir-name)))
       (shell-command (format "%s -e -R -f %s/TAGS %s" ctags dir dir))))


(defun set-tab-size (size)
  "Set the tab size for the current buffer."
  
  (interactive "NSize: ") ; Number
  
  (setq-local tab-width size)
  (setq-local tab-stop-list (number-sequence 0 200 size))
  (setq-local c-basic-offset size)
  (setq-local haskell-indent-offset size))

;; ---------------------------------------------------------------------------------------
