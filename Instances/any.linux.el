(package-initialize)

(load-theme 'misterioso t)

(defconst ctags-program "ctags")
(defconst desktop-home  "~/desktops/")
(defconst dotemacs-dir  "~/dotemacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))

(defvar org-mode-map (make-sparse-keymap)) ;; Fix for org mode in Emacs 24.3

(load dotemacs-file)


;; ---------------------------------------------------------------------------------------

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 98 :width normal)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default))))
