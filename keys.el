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

(global-set-key (kbd "C-x t") 'term)


;; ;; GUI only keybindings:
;; (if (window-system)
;;     (progn
;;       ;; Remap C-i to yank:
;;       (define-key input-decode-map [?\C-i] [C-i])
;;       (global-set-key (kbd "<C-i>") 'yank)))    ; Angled brackets required due to decoding.
