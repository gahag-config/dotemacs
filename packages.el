;; -*- byte-compile-warnings: (not free-vars); -*-
;; Package setup -------------------------------------------------------------------------
(require 'package)

(setq-default package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                                 ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


;; Features ------------------------------------------------------------------------------
(if (boundp 'package-features)
    (mapc (lambda (feature) (set feature t))
          package-features))

(defmacro package-feature (feat &rest code)
  `(when (boundp ,feat)
         ,(cons 'progn code)))


;; Use-package ---------------------------------------------------------------------------
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; Emacs ---------------------------------------------------------------------------------
(use-package emacs
  :ensure nil
  :diminish ((eldoc-mode . "Σ")
             (abbrev-mode . "Λ")
             (visual-line-mode . "↲")
             (subword-mode . ""))
  :bind (("C-M-u" . undo)
         ("C-x C-r" . replace-string)
         ("C-;"   . comment-line)
         ("s-SPC" . cycle-spacing)
         ("C-."   . pop-tag-mark)

         ("C-{" . backward-paragraph)
         ("C-}" . forward-paragraph)

         ("C-x k" . kill-current-buffer)

         ("M-o" . other-frame)

         ("C-x -" . text-scale-adjust)
         ("C-x +" . text-scale-adjust)

         ("M-#" . quick-calc)

         ("C-q" . pop-to-mark-command)

         ("C-z" . quoted-insert))
  :bind (:map occur-mode-map
              ("n" . occur-next)
              ("p" . occur-prev))
  :hook ((help-mode . visual-line-mode))
  :config
  (setq-default make-backup-files nil
                truncate-lines t ;; disable word-wrap.
                require-final-newline t

                fill-column 90
                comment-column 0

                ring-bell-function 'ignore

                frame-resize-pixelwise t)

  ;; Fix prompt
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; Enable functions
  (put 'narrow-to-region 'disabled nil)
  (put 'upcase-region    'disabled nil)
  (put 'downcase-region  'disabled nil)

  ;; File local variables
  (defun reload-local-variables ()
    (interactive)
    (hack-local-variables))
  (put 'before-save-hook 'safe-local-variable (lambda (_) t))
  (put 'after-save-hook  'safe-local-variable (lambda (_) t))

  ;; Temp files
  (defun find-temp-file (filename)
    "Find new temporary file"
    (interactive "sFile name: ") ;; String
    (find-file (make-temp-file (concat filename "-") nil ".txt")))

  ;; Shell
  (defun shell-command-on-buffer ()
    (interactive)
    (shell-command-on-region (point-min)
                             (point-max)
                             (read-shell-command "Shell command on buffer: ")
                             (current-buffer)))

  ;; ASCII-HEX converion
  (defun hex-decode-string (hex-string)
    (let ((res nil))
      (dotimes (i (/ (length hex-string) 2) (apply #'concat (reverse res)))
        (let ((hex-byte (substring hex-string (* 2 i) (* 2 (+ i 1)))))
          (push (format "%c" (string-to-number hex-byte 16)) res)))))

  (defun hex-encode-string (ascii-string)
    (let ((res nil))
      (dotimes (i (length ascii-string) (apply #'concat (reverse res)))
        (let ((ascii-char (substring ascii-string i  (+ i 1))))
          (push (format "%x" (string-to-char ascii-char)) res)))))

  (defun hex-decode-region (start end)
    "Decode a hex string in the selected region."
    (interactive "r")
    (save-excursion
      (let* ((decoded-text
              (hex-decode-string
               (buffer-substring start end))))
        (delete-region start end)
        (insert decoded-text))))

  (defun hex-encode-region (start end)
    "Encode a hex string in the selected region."
    (interactive "r")
    (save-excursion
      (let* ((encoded-text
              (hex-encode-string
               (buffer-substring start end))))
        (delete-region start end)
        (insert encoded-text))))

  (defun url-decode (start end)
    "Url-decode region"
    (interactive "r")
    (let ((input (buffer-substring start end)))
      (require 'url-util)
      (delete-region start end)
      (insert
       (json-encode
        (mapcar
         (lambda (pair) (mapcar 'url-unhex-string (split-string pair "=")))
         (split-string input "&"))))
      (json-pretty-print (mark) (point))))

  (defun jwt-decode ()
    "Jwt-decode region"
    (interactive)
    (let ((start (point)))
      (search-forward ".")
      (delete-char -1)
      (base64-decode-region start (point) 't)
      (json-pretty-print start (point)))
    (newline)
    (let ((start (point)))
      (search-forward ".")
      (delete-char -1)
      (base64-decode-region start (point) 't)
      (json-pretty-print start (point)))
    (newline))

  (defun get-secret (secret)
    (funcall (plist-get (car (auth-source-search :host secret)) :secret)))

  (defun get-url-secret (url)
    (funcall (plist-get (car (auth-source-search :host (url-host (url-generic-parse-url url)))) :secret)))


 ;; Modes
  (when window-system
    (tool-bar-mode -1)
    (scroll-bar-mode -1))
  (menu-bar-mode -1)
  (column-number-mode)
  ;; (global-display-line-numbers-mode)

  (delete-selection-mode)
  (electric-pair-mode)
  (show-paren-mode)
  (global-auto-revert-mode t)
  (desktop-save-mode t)
  (recentf-mode t)
  (eldoc-mode)
  (global-subword-mode)
  ;;(semantic-mode)

  ;; Ispell and flyspell
  (setq ispell-silently-savep t)

  ;; Calc
  (setq-default calc-multiplication-has-precedence nil)

  ;; Keys
  (global-unset-key "") ;; ESC ESC ESC
  (when (window-system) ;; GUI only keybindings:
    ;; Remap C-i to yank:
    (define-key input-decode-map [?\C-i] [C-i])
    (global-set-key (kbd "<C-i>") 'yank) ; Angled brackets required due to decoding.
    (define-key isearch-mode-map (kbd "<C-i>") 'isearch-yank-kill))

  ;; Aliases
  (defalias 'open 'browse-url-of-buffer)

  ;; Registers
  (set-register ?e '(file . "~/.config/emacs/init.el"))
  (set-register ?E `(file . ,dotemacs-file))
  (set-register ?p `(file . ,(concat dotemacs-dir "packages.el")))

  ;; Authentication
  (add-to-list 'auth-sources '"~/.config/authinfo")
  (setq network-stream-use-client-certificates 't))


;; Whitespace ----------------------------------------------------------------------------
(use-package whitespace
  :ensure nil
  :diminish "→"
  :hook (prog-mode . whitespace-mode)
  :init
  (defvar indent-size 2)

  (defun indent-tab-mode ()
    (interactive)
    (setq-local indent-tabs-mode t))

  (defun indent-spaces-mode ()
    (interactive)
    (setq-local indent-tabs-mode nil))

  (defun set-indent-size (size global)
    "Set the tab size for the current buffer."
    (interactive (list (read-number "Size: ")
                       (y-or-n-p "Global? ")))
    (let ((variables '(tab-width
                       c-basic-offset
                       css-indent-offset
                       haskell-indent-offset
                       js-indent-level
                       typescript-indent-level
                       lua-indent-level
                       python-indent-offset
                       ruby-indent-level
                       rust-indent-offset
                       sh-basic-offset
                       markdown-list-indent-width
                       web-mode-markup-indent-offset
                       web-mode-code-indent-offset)))
      (mapc (lambda (var)
              (if global
                  (set-default var size)
                  (progn
                    (make-local-variable var)
                    (set var size))))
            variables)))

  (defun align-whitespace (size)
    "Align columns delimited by whitespace."
    (interactive "NSize: ") ;; Number
    (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)\\s-" 1 size 't))

  :config
  (set-indent-size indent-size 't)
  (setq-default backward-delete-char-untabify-method nil

                whitespace-style '(face tabs tab-mark trailing)
                whitespace-display-mappings '((tab-mark 9 [?\u2502 9])))) ; 9 = ascii TAB


;; Recentf -------------------------------------------------------------------------------
(use-package recentf
  :ensure nil
  :config
  (setq-default recentf-save-file       "~/.cache/emacs/recent-files"
                recentf-max-saved-items 50
                recentf-max-menu-items  15))


;; Windmove ------------------------------------------------------------------------------
(use-package windmove
  :ensure nil
  :defer nil
  :bind (("s-e" . windmove-up)
         ("s-f" . windmove-right)
         ("s-d" . windmove-down)
         ("s-s" . windmove-left))
  :config
  (windmove-default-keybindings 'meta))


;; Misc ----------------------------------------------------------------------------------
(use-package misc
  :defer t
  :bind ("M-z" . zap-up-to-char))


;; Modeline ------------------------------------------------------------------------------
(use-package powerline
  :ensure t
  :config (setq powerline-height 18
                powerline-default-separator 'slant))

(use-package diminish
  :ensure t)


;; Doom themes ---------------------------------------------------------------------------
(use-package doom-themes
  :ensure t
  :config (doom-themes-org-config))


;; Helm ----------------------------------------------------------------------------------
(use-package helm
  :ensure t
  :diminish (helm-mode . "Γ")
  :config
  (helm-mode)
  (setq helm-buffer-skip-remote-checking t ; Prevent helm-mini from querying remote buffers
        helm-buffer-max-length 40
        helm-boring-buffer-regexp-list '("\\` "
                                         "\\`\\*Async-native-compile-log\\*"
                                         "\\`\\*helm"
                                         "\\`\\*Echo Area"
                                         "\\`\\*Minibuf"
                                         "\\`\\*Quail Completions\\*"
                                         "\\`\\*Calculator\\*"
                                         "\\`\\*lsp-log\\*"
                                         "\\`\\*\\(\\w\\|-\\)+ls\\(::stderr\\)?\\*\\'"
                                         "\\`.*server-boot-ls.*"
                                         "\\`\\*rust-analyzer\\(::stderr\\)?\\*\\'"
                                         ;; "\\`\\*EGLOT"
                                         "\\`\\*Flymake"
                                         "\\`\\*Flycheck"
                                         "\\`magit-.*:"
                                         "\\`\\*tramp"
                                         "\\`\\*emacs\\*"
                                         "\\`\\*Verb log\\*"
                                         "\\`\\*Org Preview LaTeX Output\\*"
                                         "\\`\\*ein:jupyter-server\\*"
                                         "\\`\\*ein:log-all\\*"
                                         "\\`\\*ein:.*\\*\\[markdown\\]"
                                         "\\`\\*ein:.*\\*\\[python\\]"))
  :bind
  (("M-x"     . helm-M-x)
   ("M-y"     . helm-show-kill-ring)
   ("C-x C-f" . helm-find-files)
   ("C-x C-b" . helm-mini)
   ("C-x b"   . helm-mini)))


;; Company -------------------------------------------------------------------------------
(use-package company
  :ensure t
  :defer t
  :diminish "Ξ"
  :bind ("C-c SPC" . company-complete)
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode))


;; Re-builder ----------------------------------------------------------------------------
(use-package re-builder
  :config
  (setq reb-re-syntax 'string))


;; Rg ------------------------------------------------------------------------------------
(use-package rg
  :ensure t
  :commands rg
  :bind (:map rg-mode-map
              ("n" . next-line)
              ("p" . previous-line))
  :config
  (setq-default rg-command-line-flags '("-."))

  (add-to-list 'rg-custom-type-aliases '("graphql" . "*.graphqls"))
  (add-to-list 'rg-custom-type-aliases '("velocity" . "*.vm"))
  (add-to-list 'rg-custom-type-aliases '("ledger" . "*.ledger")))


;; Yasnippet -----------------------------------------------------------------------------
(use-package yasnippet
  :ensure t
  :defer t
  :diminish (yas-minor-mode . "Υ")
  :hook   (prog-mode . yas-global-mode))

(use-package yasnippet-snippets
  :ensure t
  :defer  t)

;; Flycheck ------------------------------------------------------------------------------
(use-package flycheck
  :ensure t
  :defer t
  :diminish "Ϝ"
  :hook (prog-mode . flycheck-mode)
  :config
  ; For some reason, the following does not work with setq, only with setq-default.
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq-default flycheck-checker-error-threshold 1000))


;; Flyspell ------------------------------------------------------------------------------
(use-package flyspell
  :bind (:map flyspell-mode-map
              ("C-," . nil) ;; Expand region.
              ("C-c s" . flyspell-goto-next-error)))


;; Lsp -----------------------------------------------------------------------------------
(package-feature 'feature-lsp
  (use-package lsp-mode
    :ensure t
    :commands lsp
    :diminish "λ"
    :bind (:map lsp-mode-map
                ("C-c r" . lsp-rename)
                ("C-c h" . lsp-describe-thing-at-point)
                ("C-c a" . lsp-execute-code-action)
                ("C-M-." . lsp-goto-implementation))
    :config
    (setq-default lsp-prefer-flymake nil
                  lsp-file-watch-threshold 10000
                  lsp-modeline-code-action-fallback-icon "λ"
                  lsp-headerline-breadcrumb-enable nil
                  lsp-lens-enable nil))

  (use-package lsp-ui
    :ensure t
    :defer t
    :commands lsp-ui-mode
    :bind (:map lsp-ui-mode-map
                ("C-M-," . lsp-ui-peek-find-references)
                ("M-."   . lsp-ui-peek-find-definitions))
    :config
    (setq lsp-ui-sideline-ignore-duplicate t
          lsp-ui-sideline-show-code-actions t
          lsp-ui-peek-always-show t
          lsp-ui-doc-enable nil)
    (lsp-ui-sideline-toggle-symbols-info)))


;; LLM -----------------------------------------------------------------------------------
(package-feature 'feature-llm
  (use-package gptel
    :ensure t
    :config
    (setq gptel-model "claude-3-sonnet-20240229"
          gptel-backend (gptel-make-anthropic "Claude"
                                              :stream t
                                              :key (lambda () (auth-source-pick-first-password :host "api.anthropic.com"))))))


;; Magit ---------------------------------------------------------------------------------
(use-package magit
  :ensure t
  :defer t
  :bind   ("C-x m" . magit-status)
  ;; :bind   (:map magit-file-mode-map
  ;;               ("C-x g" . nil))
  :config (setq-default magit-diff-refine-hunk 'all)
          (setq-default magit-save-repository-buffers nil)
          (setq magit-log-margin (quote (t
                                         "%Y-%m-%d %H:%M "
                                         magit-log-margin-width
                                         t
                                         10)))
          (setq magit-git-global-arguments ; magit over tramp
                (append magit-git-global-arguments
                        '("-c" "color.ui=false"
                          "-c" "color.diff=false"))))


;; Ediff ---------------------------------------------------------------------------------
(use-package ediff
  :ensure t
  :defer t
  :config (setq ediff-diff-options "-w"
                ediff-window-setup-function 'ediff-setup-windows-plain
                ediff-split-window-function 'split-window-horizontally))


;; Term ----------------------------------------------------------------------------------
(use-package vterm
  :ensure t
  :bind (("C-c t" . (lambda () (interactive) (vterm 't)))
         :map vterm-mode-map
         ("C-y" . vterm-send-C-y)
         ("M-<" . vterm--self-insert)
         ("M->" . vterm--self-insert)
         ("C-c C-j" . vterm-copy-mode)
         :map vterm-copy-mode-map
         ("C-c C-j" . vterm-copy-mode)
         ("<return>" . vterm-copy-mode))
  :init
  (define-derived-mode run-mode shell-script-mode "run" ())
  (defun org-babel-execute:run (body params)
    "Send a block of shell code to vterm."
    (vterm 't)
    (vterm-insert body)
    (vterm-send-return))
  :config
  (setq vterm-kill-buffer-on-exit t
        vterm-max-scrollback 1000000))


;; Tramp ---------------------------------------------------------------------------------
(use-package tramp
  :ensure t
  :defer t
  :config
  (setq tramp-terminal-type "tramp")  ; Use specific terminal to prevent PS1 parsing conflict.
  (add-to-list 'tramp-methods
               '("gssh"
                 (tramp-login-program        "gcloud compute ssh")
                 (tramp-login-args           (("%h")))
                 (tramp-async-args           (("-q")))
                 (tramp-remote-shell         "/bin/sh")
                 (tramp-remote-shell-args    ("-c"))
                 (tramp-gw-args              (("-o" "GlobalKnownHostsFile=/dev/null")
                                              ("-o" "UserKnownHostsFile=/dev/null")
                                              ("-o" "StrictHostKeyChecking=no")))
                 (tramp-default-port         22))))


;; Dired ---------------------------------------------------------------------------------
(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
              ("K" . dired-kill-subdir)
              ("e" . dired-toggle-read-only))
  :config
  (setq-default dired-dwim-target t
                dired-listing-switches "-alhG1v --group-directories-first"
                delete-by-moving-to-trash t
                completion-ignored-extensions (cons ".ccls-cache/" completion-ignored-extensions)))

(use-package dired-ranger
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("c" . dired-ranger-copy)
              ("Y" . dired-ranger-paste)
              ("y" . dired-ranger-move)))

(use-package dired-quick-sort
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("s" . hydra-dired-quick-sort/body)))

(use-package dired-narrow
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("N" . dired-narrow)))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("K" . dired-subtree-remove)
              ("i" . dired-subtree-insert))
  :config
  (setq dired-subtree-use-backgrounds nil
        dired-subtree-line-prefix "    "))


;; Org -----------------------------------------------------------------------------------
(use-package org
  :ensure t
  :pin gnu
  :hook ((org-mode . indent-spaces-mode)
         (org-babel-after-execute . (lambda () (when org-inline-image-overlays
                                                (org-redisplay-inline-images)))))
  :bind (:map org-mode-map
              ("C-," . nil) ;; Expand region.
              ("C-<" . org-promote-subtree)
              ("C->" . org-demote-subtree)
              ("C-c a" . org-agenda)
              ("C-c b" . org-insert-structure-template)
              ("C-j" . org-insert-heading-respect-content)
              ("C-m" . org-return-indent))
  :init
  (defvar org-babel-languages '((emacs-lisp . t)
                                (dot . t)))

  (defun org-babel-add-language (lang)
    (add-to-list 'org-babel-languages `(,lang . t))
    (org-babel-do-load-languages 'org-babel-load-languages org-babel-languages))
  :config
  ;; (mapc (lambda (arg) (setcdr arg (list (downcase (cadr arg))))) ; lowercase structure templates
  ;;   org-structure-template-alist)

  (setq org-todo-keywords '((sequence "TODO" "NEXT" "|" "DONE" "DISMISSED"))
        org-adapt-indentation t
        org-hide-emphasis-markers t
        org-ellipsis "..."
        org-catch-invisible-edits 'show-and-error
        org-list-allow-alphabetical t
        org-log-done 'time
        org-log-repeat nil
        org-tags-column 0
        org-agenda-tags-column 0
        org-export-with-toc nil
        org-export-with-planning t
        org-src-tab-acts-natively t
        org-src-fontify-natively t
        org-src-window-setup 'current-window
        org-startup-folded t

        ;; Don't highlight when refiling
        bookmark-fontify nil

        org-highlight-latex-and-related '(latex script entities)
        org-latex-preview-ltxpng-directory "/tmp/ltximg/"
        org-startup-with-latex-preview t
        org-format-latex-options (plist-put org-format-latex-options :scale 0.35)

        ;; Inline images:
        org-display-inline-images t
        org-redisplay-inline-images t
        org-startup-with-inline-images "inlineimages"

        ;; Minted setup:
        org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-minted-options '(("fontsize" "\\small") ("tabsize" "4"))
        org-latex-pdf-process
         '("latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode -output-directory %o' -pdf -f  %f"))

  (setq org-agenda-custom-commands
        '(("1" "Week schedule" agenda "display scheduled and deadlines for the current week"
           ((org-agenda-span 'week)
            (org-agenda-time-grid nil)
            (org-agenda-show-all-dates nil)
            (org-agenda-entry-types '(:deadline :scheduled))
            (org-deadline-warning-days 0)))
          ("2" "Month schedule" agenda "display scheduled and deadlines for the current month"
           ((org-agenda-span 'month)
            (org-agenda-time-grid nil)
            (org-agenda-show-all-dates nil)
            (org-agenda-entry-types '(:deadline :scheduled))
            (org-deadline-warning-days 0)))
          ))

  (put 'org-html-htmlize-output-type 'safe-local-variable (lambda (_) t))
  (put 'org-table-convert-region-max-lines 'safe-local-variable (lambda (_) t))
  (put 'org-latex-toc-command 'safe-local-variable (lambda (_) t))
  (put 'org-after-todo-state-change-hook 'safe-local-variable (lambda (_) t))
  (put 'org-hierarchical-todo-statistics 'safe-local-variable (lambda (_) t))
  (put 'org-confirm-babel-evaluate 'safe-local-variable (lambda (_) t))

  (add-to-list 'org-export-backends 'md)

  (defun org-custom-timestamp (trans back _comm)
    "Remove <> around time-stamps."
    (pcase back
      (`html
       (replace-regexp-in-string "&[lg]t;" "" trans))
      (_ ;; `latex or nil
       (replace-regexp-in-string "[<>]" "" trans))))
  (require 'ox)
  (add-to-list 'org-export-filter-timestamp-functions #'org-custom-timestamp)

  (defun org-prop (prop)
    (org-entry-get (point) prop t))

  (defun org-src (name)
    (org-element-property :value (org-element--parse-to
                                  (org-babel-find-named-block name))))

  (defun org-refile-to (headline)
    "Move current subtree to specified headline"
    (let ((previous_parent (save-excursion
                             (outline-up-heading 1)
                             (point)))
          (target-heading (org-find-exact-headline-in-buffer (capitalize headline))))
      (if target-heading
          (progn
            (org-refile nil
                        nil
                        (list headline
                              (buffer-file-name)
                              nil
                              target-heading))
            (save-excursion
              (goto-char previous_parent)
              (org-update-statistics-cookies nil))

            (org-refile-goto-last-stored)

            (save-excursion
              (outline-up-heading 1)
              (org-update-statistics-cookies nil)))
        (message "failed to resolve headline: %s" headline))))

  (defun org-refile-todo ()
    "Move current subtree to the corresponding todo heading"
    (interactive)
    (when (and (eq (org-current-level) 2)
               (not (member "pin" (org-get-tags))))
      (org-refile-to (org-get-todo-state))))

  (defun org-done-after (date)
    (interactive "SDone after: ")
    (org-tags-view nil
                   (format "CLOSED>=\"[%s]\"" date))))


(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("⁖")))

(use-package calfw
  :ensure t
  :defer t
  :after org)

(use-package calfw-org
  :ensure t
  :defer t
  :after calfw
  :commands cfw:open-org-calendar
  :config (setq cfw:org-overwrite-default-keybinding t))

(use-package ox-latex
  :ensure nil
  :defer t
  :config
  (add-to-list 'org-latex-classes
               '("letter" "\\documentclass{letter}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (setq org-latex-active-timestamp-format "{%s}"
        org-latex-inactive-timestamp-format "{%s}"))

(package-feature 'feature-org-paper
  (use-package org-ref
    :ensure t
    :after ox-latex
    :config
    (add-to-list 'org-latex-classes
                 '("abntex2"
                   "\\documentclass{abntex2}
                      [NO-DEFAULT-PACKAGES]
                      [EXTRA]"
                   ("\\chapter{%s}" . "\\chapter*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                   ("\\maketitle" . "\\imprimircapa")))))

(package-feature 'feature-org-reveal
  (use-package org-re-reveal
    :ensure t
    :after  org
    :config
    (setq org-re-reveal-revealjs-version "4"
          org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js@4.1.0"
          ;; org-re-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
          org-re-reveal-plugins '(markdown notes zoom))))

(package-feature 'feature-ob-mongo
  (use-package ob-mongo
    :ensure t
    :after org))

(package-feature 'feature-ob-async
  (use-package ob-async
    :ensure t
    :after org))

(package-feature 'feature-org-special-blocks
  (use-package org-special-block-extras
    :ensure t
    :hook (org-mode . org-special-block-extras-mode)))


(package-feature 'feature-org-presentation
  (use-package olivetti
    :ensure t
    :defer t
    :diminish
    :config
    (setq olivetti-body-width 0.7
          olivetti-minimum-body-width 80
          olivetti-recall-visual-line-mode-entry-state t))

  (use-package org-tree-slide
    :ensure t
    :after org
    :diminish (org-tree-slide-mode . "⮹")
    :bind (:map org-tree-slide-mode-map
                ("<tab>" . org-tree-slide-display-header-toggle)
                ("C-c C-n" . org-tree-slide-move-next-tree)
                ("C-c C-p" . org-tree-slide-move-previous-tree))
    :config
    (setq org-tree-slide-breadcrumbs nil
          org-tree-slide-header nil
          org-tree-slide-slide-in-effect nil
          org-tree-slide-heading-emphasis nil
          org-tree-slide-cursor-init t
          org-tree-slide-modeline-display nil
          org-tree-slide-skip-done nil
          org-tree-slide-skip-comments t
          org-tree-slide-fold-subtrees-skipped t
          org-tree-slide-skip-outline-level 0
          org-tree-slide-never-touch-face t
          org-tree-slide-activate-message (propertize "Presentation mode ON" 'face 'success)
          org-tree-slide-deactivate-message (propertize "Presentation mode OFF" 'face 'error)))

  (use-package org-presentation
    :ensure nil
    :bind ("C-c p" . org-presentation-mode)
    :init
    (define-minor-mode org-presentation-mode
      "Parameters for plain text presentations with `org-mode'."
      :init-value nil
      :global nil
      (if org-presentation-mode
          (progn
            (unless (eq major-mode 'org-mode)
              (user-error "Not in an Org buffer"))
            (org-tree-slide-mode)
            (olivetti-mode))
        (org-tree-slide-mode -1)
        (olivetti-mode -1)))))


(package-feature 'feature-org-calc
	(use-package literate-calc-mode
		:ensure t
    :diminish (literate-calc-minor-mode . "π")))


;; Docview -------------------------------------------------------------------------------
(use-package doc-view
  :ensure nil
  :config
  (setq-default doc-view-continuous t))


;; Pdf-tools -----------------------------------------------------------------------------
(package-feature 'feature-pdftools
  (use-package pdf-tools
    :ensure t
    :defer  t
    :magic  ("%PDF" . pdf-view-mode)
    :config (pdf-tools-install)))


;; SQL mode ------------------------------------------------------------------------------
(use-package sql
  :ensure nil
  :init
  (org-babel-add-language 'sql)
  (defun org-babel-execute-bq-advice (orig-fun body params)
    (if (string-equal-ignore-case (cdr (assq :engine params)) "bq")
        (with-temp-buffer
          ;; `cat |' is a workaround for a bug in bq: https://issuetracker.google.com/issues/401444933
          (insert (org-babel-eval "cat | bq query --quiet --format=prettyjson --max_rows 1000 --nouse_legacy_sql" body))
          (delete-trailing-whitespace)
          (buffer-string))
      (funcall orig-fun body params)))
  (advice-add 'org-babel-execute:sql :around #'org-babel-execute-bq-advice))

;; Elisp-mode ----------------------------------------------------------------------------
(use-package elisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . indent-spaces-mode))


;; C-mode --------------------------------------------------------------------------------
(use-package cc-mode
  :ensure nil
  :mode ("\\.impl\\'" . c++-mode)
  :hook (c-mode . c-toggle-comment-style)
  :init (org-babel-add-language 'C)
  :config
  (setq-default c-basic-offset indent-size
                c-default-style "stroustrup")
  (c-set-offset 'substatement-open 0))

(package-feature 'feature-lsp-c
  (use-package ccls
    :ensure t
    :defer t
    :hook ((c-mode c++-mode) . (lambda () (require 'ccls) (lsp)))
    :config
    (setq lsp-enable-on-type-formatting nil)))


;; Bash ----------------------------------------------------------------------------------
(use-package sh-script
  :ensure t
  :defer  t
  :init (org-babel-add-language 'shell)
  :config (setq sh-basic-offset indent-size))


;; Javascript ----------------------------------------------------------------------------
(package-feature 'feature-javascript
  (use-package js2-mode
    :ensure t
    :defer  t
    :mode "\\.js\\'"
    :hook (js2-mode . lsp)
    :config (setq js-indent-level indent-size))

  (use-package lsp-tramp-tsls
    :ensure nil
    :after lsp-mode
    :init (provide 'lsp-tramp-tsls)
    :config
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-tramp-connection '("typescript-language-server" "--stdio"))
                      :major-modes '(js-mode js2-mode typescript-mode)
                      :remote? t
                      :server-id 'lsp-tramp-tsls))))


(package-feature 'feature-jsx
  (use-package rjsx-mode
    :ensure t
    :defer  t
    :mode "\\.jsx\\'"
    :hook ((rjsx-mode . indent-spaces-mode)
           (rjsx-mode . highlight-indent-guides-mode)
           ;; (rjsx-mode . lsp)
           )
    :config (setq js-indent-level indent-size))

  ;; (use-package lsp-tramp-tsls
  ;;   :ensure nil
  ;;   :after lsp-mode
  ;;   :init (provide 'lsp-tramp-tsls)
  ;;   :config
  ;;   (lsp-register-client
  ;;    (make-lsp-client :new-connection (lsp-tramp-connection '("typescript-language-server" "--stdio"))
  ;;                     :major-modes '(js-mode js2-mode typescript-mode)
  ;;                     :remote? t
  ;;                     :server-id 'lsp-tramp-tsls)))
  )

(package-feature 'feature-typescript
  (use-package typescript-mode
    :ensure t
    :defer  t
    :mode "\\.ts\\'"
    :hook ((typescript-mode . indent-spaces-mode)
           (typescript-mode . highlight-indent-guides-mode)
           (typescript-mode . lsp))
    :config (setq typescript-indent-level indent-size))

  ;; (use-package lsp-tramp-tsls
  ;;   :ensure nil
  ;;   :after lsp-mode
  ;;   :init (provide 'lsp-tramp-tsls)
  ;;   :config
  ;;   (lsp-register-client
  ;;    (make-lsp-client :new-connection (lsp-tramp-connection '("typescript-language-server" "--stdio"))
  ;;                     :major-modes '(js-mode js2-mode typescript-mode)
  ;;                     :remote? t
  ;;                     :server-id 'lsp-tramp-tsls)))
  )


;; Java ----------------------------------------------------------------------------------
(package-feature 'feature-lsp-java
  (use-package lsp-java
    :ensure t
    :defer t
    :hook (java-mode . (lambda () (require 'lsp-java) (lsp)))
    :config
    (package-feature 'feature-lsp-java-boot
      (require 'lsp-java-boot))
    (setq lsp-java-server-install-dir "~/tw/code/java/jdtls/eclipse.jdt.ls-1.2.0/eclipse.jdt.ls-1.2.0/org.eclipse.jdt.ls.product/target/repository/"
          lsp-java-workspace-dir (expand-file-name "~/.cache/eclipse-workspace/")
          lsp-java-code-generation-hash-code-equals-use-java7objects t)

    ;; Lombok:
    (setq path-to-lombok (expand-file-name "~/tw/code/java/lombok.jar"))
    (add-to-list 'lsp-java-vmargs
                 (concat "-javaagent:" path-to-lombok))
    (add-to-list 'lsp-java-vmargs
                 (concat "-Xbootclasspath/a:" path-to-lombok))

    ;; For android projects, add these entries to the .classpath file in jdt.ls-java-project:
    ;; <classpathentry kind="src" path="app-dir-with-classpaths">
    ;; <classpathentry kind="lib"
    ;;                 path="/path/to/sdk/platforms/android-XXX/android.jar"
    ;;                 sourcepath="/path/to/sdk/sources/android-XXX">
    ))


;; Python --------------------------------------------------------------------------------
(package-feature 'feature-python
  (use-package python
    :ensure t
    :defer  t
    :hook ((python-mode . python-indent-setup)
           (python-mode . lsp))
    :init (org-babel-add-language 'python)
    :config
    (setq-default org-babel-python-command "python3")

    (defun python-indent-setup ()
      (indent-tabs-mode)
      (set-indent-size indent-size nil)
      (setq-local py-indent-tabs-mode t))

    (setq python-indent-offset indent-size
          python-guess-indent nil))

  (use-package lsp-tramp-pyls
    :ensure nil
    :after lsp-mode
    :init (provide 'lsp-tramp-pyls)
    :config
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-tramp-connection "~/.local/bin/pyls")
                      :major-modes '(python-mode)
                      :remote? t
                      :server-id 'lsp-tramp-pyls))))


;; Jupyter -------------------------------------------------------------------------------
;; There is an alternative to ein: https://github.com/nnicandro/emacs-jupyter
(package-feature 'feature-ein
 (use-package ein
   :ensure t
   :defer t
   :config
   (setq ein:polymode t)))  ; inline images and some other stuff.


;; Ruby --------------------------------------------------------------------------------
(package-feature 'feature-ruby
  (use-package ruby-mode
    :ensure t
    :defer  t
    :hook (ruby-mode . lsp)
    :init (org-babel-add-language 'ruby)
    :config
    (setq ruby-indent-level indent-size)))


;; Rust ----------------------------------------------------------------------------------
(package-feature 'feature-rust
  (use-package rust-mode
    :ensure t
    :defer  t
    :hook (rust-mode . lsp)
    :config
    (setq-default rust-indent-offset indent-size)
    (setq-default lsp-rust-server 'rust-analyzer)
    (setq-default lsp-rust-analyzer-proc-macro-enable 't)
    (setq-default lsp-rust-all-features 't)))


;; Haskell -------------------------------------------------------------------------------
(package-feature 'feature-haskell
  (use-package haskell-mode
    :ensure t
    :defer t
    :init (org-babel-add-language 'haskell)
    :hook (haskell-mode . turn-on-haskell-indent) ; Replace by structured-haskell-mode.
    :config
    (setq haskell-indent-offset indent-size
          haskell-font-lock-symbols t)

    (eval-after-load 'haskell-font-lock
      '(progn
         (defconst haskell-font-lock-symbols-alist
           '(("\\" . "λ") ("." "∘" haskell-font-lock-dot-is-not-composition)))
         ;; (setq haskell-font-lock-keywords (haskell-font-lock-keywords-create nil))
         )))

  ;; (use-package shm
  ;;   :ensure t
  ;;   :hook (haskell-mode . structured-haskell-mode))
  )

(package-feature 'feature-haskell-lsp
  (use-package intero
    :ensure t
    :defer t
    :hook (haskell-mode . intero-mode)))


;; Lua -----------------------------------------------------------------------------------
(package-feature 'feature-lua
  (use-package lua-mode
    :ensure t
    :defer t
    :hook (lua-mode . lsp)
    :init (org-babel-add-language 'lua)
    :config
    (setq lua-indent-level indent-size)))

(package-feature 'feature-lsp-lua
  (use-package lsp-lua
    :after lsp-mode
    :init (provide 'lsp-lua)
    :config
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection "lua-lsp")
                      :major-modes '(lua-mode)
                      :server-id 'lua-ls))
    (setq lsp-prefer-flymake nil)))


;; HTML ----------------------------------------------------------------------------------
(use-package web-mode
  :ensure t
  :defer t
  :mode ("\\.html\\'")
  :bind (:map web-mode-map
              ("C-c C-c" . web-mode-element-close)
              ("C-c C-n" . web-mode-tag-next)
              ("C-c C-p" . web-mode-tag-previous)
              ("C-<tab>" . web-mode-fold-or-unfold))
  :config
  (setq web-mode-markup-indent-offset indent-size
        web-mode-code-indent-offset indent-size
        web-mode-enable-current-element-highlight t))


;; Css -----------------------------------------------------------------------------------
(use-package css-mode
  :ensure nil
  :config
  (setq-default css-indent-offset indent-size))


;; Markdown ------------------------------------------------------------------------------
(use-package markdown-mode
  :ensure t
  :defer t
  :config
  (setq-default markdown-list-indent-width indent-size))


;; Json ----------------------------------------------------------------------------------
(use-package json-mode
  :ensure t
  :defer t
  :config (setq js-indent-level indent-size))


;; Yaml
(package-feature 'feature-yaml
  (use-package yaml-mode
    :ensure t
    :defer t))


;; Dockerfile ----------------------------------------------------------------------------
(package-feature 'feature-docker
  (use-package dockerfile-mode
    :ensure t
    :defer t)

  (use-package docker
    :ensure t
    :defer t
    :commands docker))


;; Highlight Indent Guides ---------------------------------------------------------------
(use-package highlight-indent-guides
  :ensure t
  :defer t
  :diminish "¦"
  :hook (emacs-lisp-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-responsive 'top))


;; Hideshow ------------------------------------------------------------------------------
(use-package hideshow
  :ensure nil
  :diminish (hs-minor-mode . "⋯")
  :bind ("C-c q" . hs-toggle)
  :config
  (defun hs-toggle ()
    (interactive)
    (unless (bound-and-true-p hs-minor-mode)
      (hs-minor-mode))
    (hs-toggle-hiding)))


;; Expand region -------------------------------------------------------------------------
(use-package expand-region
  :ensure t
  :defer t
  :bind ("C-," . er/expand-region)
  :config (setq expand-region-contract-fast-key "."))


;; Multi-line ----------------------------------------------------------------------------
(use-package multi-line
  :ensure t
  :defer t
  :bind ("C-c m" . multi-line))


;; Ace jump ------------------------------------------------------------------------------
(use-package ace-jump-mode
  :ensure t
  :defer t
  :bind ("C-x g" . ace-jump-mode))


;; Multiple cursors ----------------------------------------------------------------------
(use-package multiple-cursors
  :ensure t
  :defer t
  :bind
  (("M-p"     . mc/mark-previous-lines)
   ("M-n"     . mc/mark-next-lines)
   ("C-x C-n" . mc/mark-next-like-this)))


;; Transpose frame -----------------------------------------------------------------------
(use-package transpose-frame
  :ensure t
  :defer t
  :bind   ("C-x |" . transpose-frame))


;; Ledger --------------------------------------------------------------------------------
(package-feature 'feature-ledger
  (use-package ledger-mode
    :ensure t
    :defer t
    :mode "\\.ledger\\'"
    :hook (ledger-mode . indent-spaces-mode)
    :bind (:map ledger-mode-map
                ("C-c a" . ledger-add-transaction)
                ("C-c r" . ledger-report)
                ("M-p"   . nil)
                ("M-n"   . nil)
                ("C-M-p" . ledger-navigate-prev-xact-or-directive)
                ("C-M-n" . ledger-navigate-next-xact-or-directive))
    :config
    (setq ledger-reports  ; All default, but removing income from report.
          '(("bal"     "ledger -f %(ledger-file) bal")
            ("reg"     "ledger -f %(ledger-file) reg")
            ("account" "ledger -f %(ledger-file) reg %(account)")))))


;; PlantUML --------------------------------------------------------------------------------
(package-feature 'feature-plantuml
  (use-package plantuml-mode
    :ensure t
    :defer t
    :init (org-babel-add-language 'plantuml)
    :config
    (setq-default org-plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
    (setq-default plantuml-default-exec-mode 'jar)))


;; Togetherly ----------------------------------------------------------------------------
(package-feature 'feature-togetherly
  (use-package togetherly
    :ensure t
    :defer t))


;; HTTP clients --------------------------------------------------------------------------
(package-feature 'feature-restclient
  (use-package restclient
    :ensure t
    :defer t
    :config
    (setq restclient-inhibit-cookies t))

  (use-package ob-restclient
    :ensure t
    :defer t
    :init (org-babel-add-language 'restclient)))

(package-feature 'feature-verb
  (use-package verb
    :ensure t
    :defer t
    :bind (:map verb-mode-map
                ("C-c v" . verb-send-request-on-point))))


;; Langtool ------------------------------------------------------------------------------
(package-feature 'feature-langtool  ; requires the languagetool package
  (use-package langtool
    :ensure t
    :defer t
    :init
    (setq langtool-java-classpath
          "/usr/share/languagetool:/usr/share/java/languagetool/*")))


;; CommandLog ----------------------------------------------------------------------------
(package-feature 'feature-command-log
  (use-package command-log-mode
    :ensure t
    :defer t
    :diminish "⌘"))


;; ---------------------------------------------------------------------------------------
