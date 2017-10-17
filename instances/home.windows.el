(package-initialize)

(load-theme 'monokai t)

(defconst ctags-program "C:/Users/gahag/Desktop/gahag/OSs/Windows/Programs/ctags.exe")
(defconst desktop-home  "C:/Users/gahag/Desktop/gahag/Programming/Config/emacs/desktops-win/")
(defconst dotemacs-dir  "C:/Users/gahag/Desktop/gahag/Programming/Config/emacs/dotemacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))

(load dotemacs-file)

(setq omnisharp-server-executable-path "C:/Users/gahag/Desktop/gahag/Programming/Config/emacs/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp.exe")


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
    ("05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "26ce7eea701bfd143ac536e6805224cff5598b75effb60f047878fe9c4833ae4" default)))
 '(flycheck-gcc-include-path
   (quote
    ("C:/Users/gahag/Desktop/gahag/programming/langs/c/aeds/"))
   (quote
    ("C:/Users/gahag/Desktop/gahag/programming/langs/cpp/"))))
