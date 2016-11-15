(package-initialize)

(load-theme 'misterioso t)

(defconst ctags-program "ctags")
(defconst desktop-home  "/gahag/Programming/Config/emacs/desktops/")
(defconst dotemacs-dir  "/gahag/Programming/Config/emacs/dotemacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))

(load dotemacs-file)

(setq omnisharp-server-executable-path "/gahag/Programming/Config/emacs/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp.exe")


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
 '(flycheck-clang-include-path
   (quote
    ("/gahag/Programming/Langs/Cpp/AEDS/1/TP/src/" "/gahag/Programming/Langs/Cpp/")))
 '(flycheck-gcc-include-path
   (quote
    ("/gahag/Programming/Langs/Cpp/Functional/Proto/Lib/" "/gahag/Programming/Langs/Cpp/" "/gahag/Programming/Langs/Cpp/AEDS/1/TP/src/")))
 '(package-selected-packages
   (quote
    (yasnippet sr-speedbar projectile powerline perspective paredit omnisharp nyan-mode multiple-cursors monokai-theme molokai-theme lua-mode heroku-theme helm haskell-mode fsharp-mode flatui-theme fill-column-indicator expand-region elm-mode company color-theme-solarized c-eldoc ace-jump-mode))))
