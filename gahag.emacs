(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

;; ---------------------------------------------------------------------------------------

(load-theme (if (eq system-type 'windows-nt) 'monokai 'misterioso) t)

(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings 'meta)

(setq-default make-backup-files nil)
(setq-default x-select-enable-clipboard t)
(set-default 'truncate-lines t)

(setq recentf-save-file       "~/.emacs.d/.cache/recent-files"
      recentf-max-saved-items 200
      recentf-max-menu-items  15)

(setq-default cursor-type 'bar)
(set-cursor-color "WhiteSmoke")

(setq-default fci-rule-color "#888888")
(setq-default fci-rule-column 90)

(setq-default tab-width 2)
(setq-default tab-always-indent nil)
(setq-default indent-tabs-mode  nil)
(setq-default tab-stop-list (quote (0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
                                    40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74
                                    76 78 80 82 84 86 88 90 92 94 96 98 100 102 104 106 108
                                    110 112 114 116 118 120 122 124 126 128 130 132 134 136
                                    138 140 142 144 146 148 150 152 154 156 158 160 162 164
                                    166 168 170 172 174 176 178 180 182 184 186 188 190 192
                                    194 196 198 200)))


(setq-default c-default-style "c#")
(setq-default c-basic-offset 2)
(c-set-offset 'substatement-open 0)

(setq-default haskell-font-lock-symbols t)
(setq-default haskell-indent-offset 2)
(setq-default haskell-mode-hook (quote (turn-on-haskell-indent)))

;; ---------------------------------------------------------------------------------------

(define-globalized-minor-mode global-fci-mode fci-mode turn-on-fci-mode)

(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda () (if (not (minibufferp (current-buffer)))
                                  (auto-complete-mode 1))))


(global-linum-mode)
;;(global-fci-mode)
(nyan-mode)
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
(projectile-global-mode)
(recentf-mode t)
(desktop-save-mode t)

;; ---------------------------------------------------------------------------------------

(global-set-key "\M-x"     'helm-M-x)
(global-set-key "\M-y"     'helm-show-kill-ring)
(global-set-key "\C-x\C-f" 'helm-find-files)
(global-set-key "\C-xb"    'helm-mini)

(global-set-key "\C-@"        'er/expand-region)
(global-set-key "\C-xg"       'ace-jump-mode)
(global-set-key "\C-x\C-n"    'mc/mark-next-lines)
(global-set-key "\C-x\C-\M-n" 'mc/mark-next-like-this)
(global-set-key "\C-xk"       'kill-this-buffer)

;; ---------------------------------------------------------------------------------------

(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-language-standard "c++11")))
(add-hook 'c-mode-hook
          (lambda () (setq flycheck-gcc-language-standard "c99")))


(add-hook 'term-mode-hook
          '(lambda () (term-set-escape-char ?\C-x)))


(load-library "inf-haskell")

(defun my-inf-haskell-hook ()
  (setq comint-prompt-regexp 
        (concat comint-prompt-regexp "\\|^.> ")))

(add-hook 'inferior-haskell-mode-hook 'my-inf-haskell-hook)


(eval-after-load 'haskell-font-lock
 '(progn (defconst haskell-font-lock-symbols-alist
                   '(("\\" . "λ") ("." "∘" haskell-font-lock-dot-is-not-composition)))
         (setq haskell-font-lock-keywords (haskell-font-lock-keywords-create nil))))

;; ---------------------------------------------------------------------------------------

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (let ((dir (directory-file-name dir-name)))
       (shell-command (format "%s -e -R -f %s/TAGS %s" ctags dir dir)))
)

;; ---------------------------------------------------------------------------------------
