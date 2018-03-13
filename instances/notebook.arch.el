(package-initialize)

(defconst ctags-program "ctags")
(defconst emacs-home    "/gahag/programming/config/emacs")
(defconst desktop-home  (concat emacs-home "/desktops/"))
(defconst dotemacs-dir  (concat emacs-home "/dotemacs/"))
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))

(add-to-list 'custom-theme-load-path themes-dir)
(load-theme 'doom-gahag t)

(load dotemacs-file)


;; ---------------------------------------------------------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 97 :width normal)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(flycheck-clang-include-path (quote ("/gahag/programming/projects/aeds/3/tp3/src/")))
 '(flycheck-gcc-include-path (quote ("/gahag/programming/projects/aeds/")))
 '(package-selected-packages
   (quote
    (magit intero nyan-mode ace-jump-mode flymake-haskell-multi haskell-mode c-eldoc pdf-tools latex-preview-pane markdown-mode helm multiple-cursors expand-region yasnippet flycheck powerline auto-complete)))
 '(shell-escape-mode "-shell-escape"))
