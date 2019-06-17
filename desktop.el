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
