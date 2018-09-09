;; Cursor
(setq-default cursor-type 'bar)
(set-cursor-color "WhiteSmoke")


(add-to-list 'custom-theme-load-path themes-dir)
(load (concat themes-dir "powerline-theme.el"))


(defadvice load-theme (before clear-previous-themes activate)
  "Clear existing theme settings instead of layering them."
  (mapc #'disable-theme custom-enabled-themes))


(defun load-X-theme (theme)
  "Load theme when not in a terminal."
  (if (display-graphic-p)
      (load-theme theme t)))


(defun powerline-gahag-theme ()
  "Setup a mode-line with major and minor modes centered."
  (setq-default mode-line-format powerline-gahag-format))
