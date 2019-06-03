(package-initialize)

(defconst ctags-program "C:/Users/gahag/Desktop/gahag/OSs/Windows/Programs/ctags.exe")
(defconst emacs-home  "C:/Users/gahag/Desktop/gahag/config/emacs/")
(defconst desktop-home  (concat emacs-home "desktops-win/"))
(defconst dotemacs-dir  (concat emacs-home "dotemacs/"))
(defconst dotemacs-file (concat dotemacs-dir "gahag.el"))
(defconst themes-dir    (concat dotemacs-dir "themes/"))
(setq omnisharp-server-executable-path "C:/Users/gahag/Desktop/gahag/config/emacs/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp.exe")
;; (setq doc-view-ghostscript-program "gswin32c") ;; Fix doc-view on windows.
;; (setq find-program "C:/Users/gahag/Desktop/gahag/oss/windows/programs/emacs-24.4/bin/find.exe")

(load dotemacs-file)

(load-theme 'doom-gahag-light t)
(powerline-gahag-light-theme)

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
 '(package-selected-packages
   (quote
    (ox-reveal calfw calfw-org transpose-frame use-package yasnippet-snippets markdown-mode pdf-tools flatui-theme solarized-theme tango-plus-theme spaceline org-bullets doom-themes magit intero monokai-theme yasnippet powerline multiple-cursors latex-preview-pane helm haskell-mode gh-md flycheck expand-region csharp-mode color-theme c-eldoc ace-jump-mode company))))
