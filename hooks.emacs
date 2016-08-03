(defun fix-parenthesis () (local-set-key "\(" 'self-insert-command)
                          (local-set-key "\)" 'self-insert-command))

(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-language-standard "c++17")))


(add-hook 'c-mode-hook
          (lambda () (setq comment-start "//"
                           comment-end   ""
                           flycheck-gcc-language-standard "c99")
                     (fix-parenthesis)))


(add-hook 'csharp-mode-hook 'fix-parenthesis)


(add-hook 'term-mode-hook
          '(lambda () (term-set-escape-char ?\C-x)))
