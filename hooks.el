(defun fix-parenthesis () (local-set-key "\(" 'self-insert-command)
                          (local-set-key "\)" 'self-insert-command))


(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


(add-hook 'haskell-mode-hook 'intero-mode)


(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-language-standard "c++17"
                           flycheck-clang-language-standard "c++1z")
                     (fix-parenthesis)))


(add-hook 'c-mode-hook
          (lambda () (setq comment-start "//"
                           comment-end   ""
                           flycheck-gcc-language-standard "c99"
                           flycheck-clang-language-standard "c99")
                     (fix-parenthesis)
                     (c-turn-on-eldoc-mode)))


(add-hook 'csharp-mode-hook 'fix-parenthesis)


(add-hook 'term-mode-hook
          (lambda () (setq yas-dont-activate t)))


(add-hook 'pdf-tools-enabled-hook
          (lambda() (nlinum-mode -1)
                    (auto-revert-mode t)))
