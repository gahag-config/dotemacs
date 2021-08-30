;; Cursor
(setq-default cursor-type 'bar)


(defadvice load-theme (before clear-previous-themes activate)
  "Clear existing theme settings instead of layering them."
  (mapc #'disable-theme custom-enabled-themes))


(defun load-X-theme (theme)
  "Load theme when not in a terminal."
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar #'symbol-name
				                             (custom-available-themes))))))
  (if (display-graphic-p)
      (load-theme theme t)))


(defun load-powerline-theme (theme)
  "Load a powerline theme from the themes directory"
  (load (concat themes-dir "powerline-" theme "-theme.el")))

(defun powerline-gahag-theme ()
  "Setup a mode-line with major and minor modes centered."
  (setq-default mode-line-format powerline-gahag-format))

(defun powerline-gahag-light-theme ()
  "Setup a mode-line with major and minor modes centered."
  (setq-default mode-line-format powerline-gahag-light-format))


(add-to-list 'custom-theme-load-path themes-dir)
(load-powerline-theme "gahag")
(load-powerline-theme "gahag-light")
