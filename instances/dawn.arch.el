;(package-initialize)

(defconst emacs-home    "/effy/config/emacs/")
(defconst desktop-home  (concat emacs-home "desktops/"))
(defconst dotemacs-dir  (concat emacs-home "dotemacs/"))
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))

;; (defvar org-mode-map (make-sparse-keymap)) ;; Fix for org mode in Emacs 24.3

(load-theme 'misterioso)

(load dotemacs-file)

(powerline-gahag-theme)

;; ---------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-safe-themes
   (quote
    ("9aa31b4b4b84965818055d3fb80ffc2efa2a8d4ec068e202bd26a8da26415bd5" "4204531acf5fd16b257d7028fcbae9034021e06f1197527e01da34792380ebe4" "a8810eb3e7166f6d1c5825d6de963c45d6d9ea5eb037728c2ff2e0349c4a3a28" default)))
 '(package-selected-packages
   (quote
    (helm-spotify-plus latex-preview-pane togetherly htmlize ledger-mode transpose-frame multiple-cursors ace-jump-mode expand-region intero lsp-python projectile cquery pdf-tools ox-reveal calfw-org calfw dired-quick-sort dired-ranger magit company-lsp lsp-ui lsp-mode flycheck yasnippet-snippets use-package try powerline helm doom-themes company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#eff0f2" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(cursor ((t (:background "black"))))
 '(custom-state ((t (:foreground "#487cbc"))))
 '(custom-variable-tag ((t (:foreground "midnight blue" :weight bold))))
 '(dired-directory ((t (:inherit font-lock-function-name-face :foreground "#487cbc"))))
 '(dired-mark ((t (:inherit font-lock-constant-face))))
 '(font-lock-function-name-face ((t (:foreground "dark cyan" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "midnight blue" :weight bold))))
 '(font-lock-string-face ((t (:foreground "gray22" :weight extra-bold))))
 '(font-lock-type-face ((t (:foreground "midnight blue" :weight bold))))
 '(font-lock-variable-name-face ((t (:foreground "dark red"))))
 '(header-line-highlight ((t (:background "light cyan"))))
 '(helm-ff-dotted-directory ((t (:background "#bcbdbe" :foreground "black"))))
 '(helm-ff-executable ((t (:foreground "dark red"))))
 '(helm-selection ((t (:background "#bcbdbe"))))
 '(helm-source-header ((t (:background "dark cyan" :foreground "black" :weight bold :height 1.3 :family "Sans Serif"))))
 '(highlight ((t (:background "pale turquoise"))))
 '(isearch ((t (:background "light cyan" :foreground "black"))))
 '(lsp-face-highlight-read ((t (:inherit highlight :underline t))))
 '(lsp-face-highlight-textual ((t (:inherit nil))))
 '(lsp-face-highlight-write ((t (:inherit highlight :slant italic))))
 '(region ((t (:background "#549dd9"))))
 '(show-paren-match ((t (:background "indian red")))))
