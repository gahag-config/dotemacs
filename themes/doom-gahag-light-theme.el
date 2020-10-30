;;; doom-gahag-light-theme.el --- inspired by Nord
(require 'doom-themes)

;;
(defgroup doom-gahag-light-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-gahag-light-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-gahag-light-theme
  :type 'boolean)

(defcustom doom-gahag-light-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-gahag-light-theme
  :type 'boolean)

(defcustom doom-gahag-light-comment-bg doom-gahag-light-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-gahag-light-theme
  :type 'boolean)

(defcustom doom-gahag-light-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-gahag-light-theme
  :type '(or integer boolean))

(defcustom doom-gahag-light-region-highlight t
  "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
  :group 'doom-gahag-light-theme
  :type 'symbol)

;;
(def-doom-theme doom-gahag-light
  "A dark theme inspired by Nord-Light."

  ;; name        default   256       16
  ((bg '("#eff0f1" nil nil))
   (bg-alt '("#D8DEE9" nil nil))
   (base0 '("#F0F4FC" "black" "black"))
   (base1 '("#E3EAF5" "#1e1e1e" "brightblack"))
   (base2 '("#D8DEE9" "#2e2e2e" "brightblack"))
   (base3 '("#C2D0E7" "#262626" "brightblack"))
   (base4 '("#B8C5DB" "#3f3f3f" "brightblack"))
   (base5 '("#AEBACF" "#525252" "brightblack"))
   (base6 '("#A1ACC0" "#6b6b6b" "brightblack"))
   (base7 '("#60728C" "#979797" "brightblack"))
   (base8 '("#485163" "#dfdfdf" "white"))
   (fg '("#1c2028" "#2d2d2d" "white"))
   (fg-alt '("#2E3440" "#bfbfbf" "brightwhite"))

   (grey base6)
   (silver      '("#dfe6e9" "#dfe6e9" "grey"))
   (black       '("#000000" "#000000" "black"))
   (bright-red  '("#ff0000" "#ff6655" "red"))
   (red         '("#9A2617" "#ff6655" "red"))
   (orange      '("#fa8e00" "#dd8844" "brightred"))
   (green       '("#079992" "#99bb66" "green"))
   (teal        '("#29838D" "#44b9b1" "brightgreen"))
   (yellow      '("#fa8231" "#ECBE7B" "yellow"))
   (bright-blue '("#3498db" "#3498db" "brightblue"))
   (blue        '("#223fae" "#51afef" "brightblue"))
   (dark-blue   '("#5272AF" "#2257A0" "blue"))
   (magenta     '("#8854d0" "#c678dd" "magenta"))
   (violet      '("#c1408c" "#a9a1e1" "brightmagenta"))
   (cyan        '("#398EAC" "#46D9FF" "brightcyan"))
   (dark-cyan   '("#2C7088" "#5699AF" "cyan"))

   ;; face categories -- required for all themes
   (highlight (doom-blend blue bg 0.8))
   (vertical-bar (doom-darken bg 0.15))
   (selection (doom-darken bg 0.05))
   (builtin blue)
   (comments (if doom-gahag-light-brighter-comments dark-cyan (doom-darken base5 0.2)))
   (doc-comments (doom-darken (if doom-gahag-light-brighter-comments dark-cyan base5) 0.25))
   (constants blue)
   (functions fg)
   (keywords blue)
   (methods fg)
   (operators blue)
   (type green)
   (strings fg)
   (variables fg)
   (numbers black)
   (region (pcase doom-gahag-light-region-highlight
             ((\` frost) (doom-lighten teal 0.5))
             ((\` snowstorm) base0)
             (_ selection)))
   (error bright-red)
   (warning yellow)
   (success green)
   (vc-modified orange)
   (vc-added green)
   (vc-deleted bright-red)

   ;; custom categories
   (hidden `(,(car bg) "black" "black"))
   (-modeline-bright doom-gahag-light-brighter-modeline)
   (-modeline-pad
    (when doom-gahag-light-padded-modeline
      (if (integerp doom-gahag-light-padded-modeline) doom-gahag-light-padded-modeline 4)))

   (modeline-fg fg)
   (modeline-fg-alt fg-alt)

   (modeline-bg bright-blue
    ;; (if -modeline-bright
    ;;     (doom-blend bg blue 0.7)
    ;;   `(,(doom-darken (car bg) 0.03) ,@(cdr base0)))
    )
   (modeline-bg-l bright-blue
    ;; (if -modeline-bright
    ;;     (doom-blend bg blue 0.7)
    ;;   `(,(doom-darken (car bg) 0.02) ,@(cdr base0)))
    )
   (modeline-bg-inactive ;; (doom-darken bg 0.01)
                         silver)
   (modeline-bg-inactive-l ;; `(,(car bg) ,@(cdr base1))
                           silver)

   (modeline-pad fg)
   (modeline-pad-inactive fg)
  )


  ;; --- extra faces ------------------------
  ((cursor :background black)

   ((region &override)
    :foreground
    (when (memq doom-gahag-light-region-highlight '(frost snowstorm))
      bg-alt))

   ((font-lock-keyword-face &override) :weight 'medium )
   ((font-lock-type-face &override) :weight 'medium )
   ((font-lock-string-face &override) :weight 'bold )

   (header-line :background bright-blue)
   (match :foreground fg :weight 'bold)
   ((line-number &override) :foreground (doom-lighten 'base5 0.2))
   ((line-number-current-line &override) :foreground base7)
   ((paren-face-match &override) :foreground fg :background bg :weight 'ultra-bold)
   ((paren-face-mismatch &override) :foreground bright-red :background bg :weight 'ultra-bold)
   ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background base3 :weight 'light)
   ((vimish-fold-fringe &override) :foreground teal)
   (font-lock-comment-face
    :foreground comments
    :background (if doom-gahag-light-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)


   ;; isearch
   (isearch :background blue :foreground silver)
   ((lazy-highlight &override) :background base4)


   ;; powerline
   (powerline-active0 :inherit 'mode-line :foreground fg :background bright-blue)
   (powerline-active1 :inherit 'mode-line :foreground fg :background bright-blue)
   (powerline-active2 :inherit 'mode-line :foreground fg :background bright-blue)
   (powerline-inactive0 :inherit 'mode-line :foreground fg :background silver)
   (powerline-inactive1 :inherit 'mode-line :foreground fg :background silver)
   (powerline-inactive2 :inherit 'mode-line :foreground fg :background silver)

   ;; (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-pad)))
   (mode-line-inactive
    :background modeline-bg-inactive ;; :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-pad-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   ;; (doom-modeline-project-root-dir :foreground base6)
   ;; (solaire-mode-line-face
   ;;  :inherit 'mode-line
   ;;  :background modeline-bg-l
   ;;  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   ;; (solaire-mode-line-inactive-face
   ;;  :inherit 'mode-line-inactive
   ;;  :background modeline-bg-inactive-l
   ;;  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;; helm
   (helm-selection :background (doom-darken bg 0.1) :weight 'medium)
   (helm-match     :foreground highlight)
   (helm-source-header :background bg :weight 'bold)
   (helm-ff-dotted-directory :foreground (doom-lighten fg 0.5))
   (helm-ff-directory :foreground blue)
   (helm-ff-executable :foreground fg :inherit 'italic)
   (helm-ff-file-extension :foreground fg)
   (helm-buffer-modified :foreground violet)
   (helm-buffer-directory :foreground blue)
   (helm-buffer-file :foreground fg)
   (helm-non-file-buffer :foreground (doom-lighten fg 0.5))
   (helm-candidate-number :background bright-blue)
   (helm-minibuffer-prompt :foreground fg :weight 'medium)

   ;; minibuffer
   (minibuffer-prompt :foreground fg :weight 'medium)

   ;; magit
   (magit-filename :foreground fg)
   (magit-branch-local :foreground bright-blue)
   (magit-mode-line-process :foreground fg :inherit 'italic)
   (magit-blame-heading :foreground fg :background base3 :weight 'bold)
   (magit-blame-date :foreground red :weight 'medium)
   (magit-diff-file-heading-selection :background selection :foreground silver)
   (magit-diff-file-heading-highlight :foreground bg :background bright-blue :weight 'bold)
   (magit-diff-hunk-heading :foreground bg :background base5)
   (magit-diff-hunk-heading-highlight :foreground bg :background base8 :weight 'bold)
   (magit-diff-added :foreground fg :background (doom-blend green bg 0.2))
   (magit-diff-added-highlight :foreground fg :background (doom-blend green bg 0.2))
   (magit-diff-removed :foreground fg :background (doom-blend red bg 0.2))
   (magit-diff-removed-highlight :foreground fg :background (doom-blend red bg 0.2))
   (diff-refine-added :foreground fg :background (doom-blend green bg 0.2) :weight 'bold)
   (diff-refine-removed :foreground fg :background (doom-blend red bg 0.2) :weight 'bold)
   (git-commit-overlong-summary :background bg :foreground bright-red)

   ;; ediff
   (ediff-current-diff-A :background (doom-blend green bg 0.2))
   (ediff-fine-diff-A :background (doom-blend green bg 0.35))

   ;; rg
   (rg-filename-face :foreground green)

   ;; wgrep
   (wgrep-face :background (doom-blend green bg 0.2))
   (wgrep-delete-face :background (doom-blend red bg 0.2))

   ;; ivy
   (ivy-posframe :background (doom-blend blue bg 0.2))
   (ivy-virtual :foreground (doom-blend blue bg 0.8))
   (ivy-minibuffer-match-face-1 :background nil :foreground (doom-blend fg bg 0.5) :weight 'light)
   (internal-border :foreground (doom-blend blue bg 0.2) :background (doom-blend blue bg 0.2))

   ;; company
   (company-tooltip :background base2)
   (company-tooltip-selection :background bright-blue :foreground bg :weight 'medium)
   (company-preview-common :background base2 :foreground fg :inherit 'italic)

   ;; lsp
   (lsp-face-highlight-textual :weight 'bold)
   (lsp-face-highlight-read :weight 'bold)
   (lsp-face-highlight-write :weight 'bold)
   (lsp-ui-sideline-code-action :foreground (doom-darken grey 0.3))
   (lsp-modeline-code-actions-face :foreground fg)
   (lsp-ui-sideline-symbol :foreground base7)
   (lsp-ui-sideline-current-symbol :foreground fg :weight 'medium)
   (lsp-ui-sideline-symbol-info :foreground base7)
   (lsp-ui-peek-header :background grey)
   (lsp-ui-peek-selection :foreground black :background silver :weight 'medium)
   (lsp-lsp-flycheck-warning-unnecessary-face :background bg)


   ;; --- major-mode faces -------------------

   ;; whitespace-mode
   (whitespace-tab :foreground base2)

   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property :foreground green)
   (css-selector :foreground blue)

   ;; ledger-mode
   (ledger-font-posting-amount-face :foreground bright-red)
   (ledger-font-xact-highlight-face :background bg)
   (ledger-font-payee-uncleared-face :foreground fg :weight 'bold)

   ;; web-mode
   (web-mode-html-tag-face :foreground blue)
   (web-mode-html-tag-namespaced-face :foreground blue)
   (web-mode-html-tag-unclosed-face :foreground red)
   (web-mode-current-element-highlight-face :foreground blue :background bg :weight 'bold)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-code-face :background (doom-lighten base3 0.05))

   ;; nxml-mode
   (nxml-element-local-name :foreground blue)
   (nxml-delimiter :foreground blue)
   (nxml-attribute-local-name :foreground teal)
   (nxml-attribute-value :weight 'medium)
   (nxml-attribute-value-delimiter :weight 'medium)

   ;; yaml-mode
   (yaml-tab-face :background bg)

   (nav-flash-face :background region :foreground base8 :weight 'bold)
   ;; org-mode
   (org-hide :foreground hidden)
   (org-todo :foreground green :underline t :weight 'medium)
   (org-done :foreground grey :underline t :weight 'medium)
   (org-headline-done :foreground grey :weight 'medium)
   (org-checkbox :foreground green :weight 'medium)
   (org-checkbox-statistics-todo :foreground green :weight 'medium)
   (org-checkbox-statistics-done :foreground grey :weight 'medium)
   (org-date :foreground fg :weight 'medium)
   (org-link :foreground blue :underline t :weight 'regular)
   (org-level-1 :background bg :foreground blue :weight 'medium)
   (org-level-2 :background bg :foreground bright-blue :weight 'medium)
   (org-level-3 :background bg :foreground violet :weight 'medium)
   (org-level-4 :background bg :foreground green :weight 'medium)
   (org-level-5 :background bg :foreground magenta :weight 'medium)
   (org-level-6 :background bg :foreground bright-blue :weight 'medium)
   (org-level-7 :background bg :foreground violet :weight 'medium)
   (org-level-8 :background bg :foreground black :weight 'medium)
   (org-block   :background (doom-darken bg 0.02) :extend t)
   (org-block-begin-line :foreground fg-alt :weight 'bold)
   (org-table :foreground (doom-lighten fg 0.15))
   (org-code :foreground green)
   (org-footnote :foreground blue)
   (org-drawer :foreground grey)
   (solaire-org-hide-face :foreground hidden)

   ;; js2-mode
   (js2-external-variable :foreground green)
  )


  ;; --- extra variables ---------------------
  ;; ()
  )

;;; doom-gahag-light-theme.el ends here
