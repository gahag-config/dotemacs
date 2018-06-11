;; visual modes
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
; (global-display-line-numbers-mode) ; (global-linum-mode)
(column-number-mode)
(powerline-gahag-theme)
(doom-themes-org-config)

;; generic modes
(delete-selection-mode)
(electric-pair-mode)
(show-paren-mode)
(global-auto-revert-mode t)
(desktop-save-mode t)
(helm-mode)
(recentf-mode t)
(global-company-mode)
(global-flycheck-mode)
(yas-global-mode)
;;(semantic-mode)
(eldoc-mode)

;; Python
(elpy-enable)

;; Haskell
(intero-global-mode 1)
