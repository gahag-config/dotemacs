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
