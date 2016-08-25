(package-initialize)

(load-theme 'monokai t)

(defconst ctags-program "C:/Users/usuario/Desktop/THOR/Emacs/ctags.exe")
(defconst desktop-home  "C:/Users/usuario/Desktop/THOR/Emacs/desktops/")
(defconst dotemacs-dir  "C:/Users/usuario/Desktop/THOR/Emacs/dotemacs/")
(defconst dotemacs-file (concat dotemacs-dir "gahag.emacs"))

(load dotemacs-file)


(setq w32-get-true-file-attributes nil) ;; Fix read/save file bug on windows.
(setq doc-view-ghostscript-program "gswin32c") ;; Fix doc-view on windows.


(setq find-program "C:/Users/usuario/Desktop/Gabriel/Emacs/Emacs 24.5/bin/find.exe")


(add-hook 'csharp-mode-hook
          (lambda () (set-tab-size 4)))

(add-hook 'java-mode-hook
          (lambda () (set-tab-size 4)))

(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-language-standard "c++98")))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" default))))
