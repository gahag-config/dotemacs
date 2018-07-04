(global-unset-key "") ;; ESC ESC ESC

;; (global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x k") 'context-kill-buffer)
(global-set-key (kbd "C-;"  ) 'comment-line)
(global-set-key (kbd "M-SPC") 'cycle-spacing)
(global-set-key (kbd "C-."  ) 'pop-tag-mark)

(global-set-key (kbd "s-w") 'windmove-up)
(global-set-key (kbd "s-d") 'windmove-right)
(global-set-key (kbd "s-s") 'windmove-down)
(global-set-key (kbd "s-a") 'windmove-left)
