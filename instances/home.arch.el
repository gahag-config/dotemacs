(package-initialize)

(load-theme 'misterioso t)

(defconst ctags-program "ctags")
(defconst emacs-home  "/gahag/programming/config/emacs/")
(defconst desktop-home  (concat emacs-home "desktops/"))
(defconst dotemacs-dir  (concat emacs-home "dotemacs/"))
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))

(load dotemacs-file)

(setq omnisharp-server-executable-path (concat emacs-home "OmniSharpServer/OmniSharp/bin/Debug/OmniSharp.exe"))


;; ---------------------------------------------------------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 98 :width normal)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(flycheck-clang-include-path (quote ("/gahag/programming/langs/cpp/")))
 '(flycheck-gcc-include-path (quote ("/gahag/programming/langs/cpp/")))
 '(package-selected-packages
   (quote
    (lorem-ipsum gh-md markdown-preview-mode markdown-mode java-snippets yasnippet sr-speedbar projectile powerline perspective paredit omnisharp nyan-mode multiple-cursors monokai-theme molokai-theme lua-mode heroku-theme helm haskell-mode fsharp-mode flatui-theme fill-column-indicator expand-region elm-mode company color-theme-solarized c-eldoc ace-jump-mode))))
