(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda () (if (not (minibufferp (current-buffer)))
                                    (auto-complete-mode 1))))


(tool-bar-mode -1)
(menu-bar-mode -1)
(global-linum-mode)
(powerline-center-theme)
(column-number-mode)

(real-global-auto-complete-mode)
(global-flycheck-mode)
(yas-global-mode)
;;(semantic-mode)
(eldoc-mode)
(electric-pair-mode)
(delete-selection-mode)
(show-paren-mode)

;;(projectile-global-mode)
(helm-mode)
(recentf-mode t)
(desktop-save-mode t)
(global-auto-revert-mode t)
