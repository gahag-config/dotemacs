(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR.
  
  \(fn arg char)"
    'interactive)


(eval-after-load 'haskell-font-lock
 '(progn (defconst haskell-font-lock-symbols-alist
                   '(("\\" . "λ") ("." "∘" haskell-font-lock-dot-is-not-composition)))
         ;(setq haskell-font-lock-keywords (haskell-font-lock-keywords-create nil))
         ))


;; These conflict with windmove.
(require 'org)
(define-key org-mode-map (kbd "<M-up>")    nil)
(define-key org-mode-map (kbd "<M-down>")  nil)
(define-key org-mode-map (kbd "<M-left>")  nil)
(define-key org-mode-map (kbd "<M-right>") nil)
