(defun create-tags (dir-name)
  "Create tags file."
  
  (interactive "DDirectory: ")
  
  (let ((dir (directory-file-name dir-name)))
       (shell-command (format "%s -e -R -f \"%s\"/TAGS \"%s\"" ctags-program dir dir))))


(defun desktop-save-in-desktop-dir-release ()
  "Save the desktop in directory `desktop-dirname' and release."
  (interactive)
  (if desktop-dirname
      (desktop-save desktop-dirname t)
    (call-interactively 'desktop-save))
  (message "Desktop saved in %s" (abbreviate-file-name desktop-dirname)))

(defun desktop-create (desktop-name)
  "Create new desktop"
  
  (interactive "sDesktop name: ")
  
  (let ((desktop-dir (concat desktop-home desktop-name)))
    (desktop-save-in-desktop-dir-release)
    (make-directory     desktop-dir)
    (desktop-save       desktop-dir)
    (desktop-change-dir desktop-dir)))


(defun desktop-switch (dir-name)
  "Switch to desktop"
  
  (interactive (list (read-directory-name "Directory: "
                                          desktop-home)))
  
  (desktop-save-in-desktop-dir)
  (desktop-change-dir dir-name))


(defun set-tab-size (size)
  "Set the tab size for the current buffer."
  
  (interactive "NSize: ") ;; Number
  
  (setq-local tab-width size)
  (setq-local tab-stop-list (number-sequence 0 200 size))
  (setq-local c-basic-offset size)
  (setq-local haskell-indent-offset size))


(defun find-temp-file (filename)
  "Find new temporary file"
  
  (interactive "sFile name: ") ;; String
  
  (find-file (make-temp-file filename)))


(defun align-whitespace (size)
  "Align columns delimited by whitespace."
  
  (interactive "NSize: ") ;; Number
  
  (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)\\s-" 1 size 't))


(defun context-kill-buffer (arg)
  "Kill buffer, taking gnuclient into account."
  (interactive "p")
  (if (and (boundp 'gnuserv-minor-mode)
           gnuserv-minor-mode)
      (gnuserv-edit)
      (kill-buffer (current-buffer))))
