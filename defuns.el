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


(defun reload-local-variables ()
  "reload file local variables for the current buffer"
  (interactive)
  (hack-local-variables))
