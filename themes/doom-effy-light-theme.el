;;; doom-effy-light-theme.el --- Effy-Light theme

(require 'doom-themes)

(defgroup doom-effy-light-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-effy-light-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-effy-light-theme
  :type 'boolean)

(defcustom doom-effy-light-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-effy-light-theme
  :type 'boolean)

(defcustom doom-effy-light-comment-bg doom-effy-light-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-effy-light-theme
  :type 'boolean)

(defcustom doom-effy-light-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-effy-light-theme
  :type '(or integer boolean))

(defcustom doom-effy-light-region-highlight t
  "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
  :group 'doom-effy-light-theme
  :type 'symbol)

(def-doom-theme doom-effy-light
  "A dark effy-light theme."

  ;; name        default   256       16
  ((bg         '("#eff0f2" nil       nil ))
   (bg-alt     '("#eeeeee" nil       nil ))
   (base0      '("#fafafa" "#dfdfdf" nil ))
   (base1      '("#f5f5f5" "#979797" nil ))
   (base2      '("#eeeeee" "#6b6b6b" nil ))
   (base3      '("#e0e0e0" "#525252" nil ))
   (base4      '("#bdbdbd" "#3f3f3f" nil ))
   (base5      '("#588f56" "#262626" nil ))
   (base6      '("#757575" "#2e2e2e" nil ))
   (base7      '("#616161" "#1e1e1e" nil ))
   (base8      '("#424242" "black"   nil ))
   (base9 '("#A1ACC0" "#6b6b6b" "brightblack"))
   
   (fg         '("#2a2a2a" "#2a2a2a" nil ))
   (fg-alt     '("#454545" "#757575" nil ))
   
   (grey base9)
   (black      '("#000000" "#000000" "black"))
   (red        '("#99324b" "#ff6655" nil ))
   (bright-red  '("#ff0000" "#ff6655" "red"))
   (orange     '("#ac4426" "#dd8844" nil ))
   (green      '("#4f894c" "#99bb66" nil ))
   (teal       '("#29838d" "#44b9b1" nil ))
   (yellow     '("#9a7500" "#ECBE7B" nil ))
   (blue       '("#3b6ea8" "#51afef" nil ))
   (cblue      '("#487cbc" "#487cbc" nil ))
   (mblue      '("midnight blue" "midnight blue" nil ))
   (dark-blue  '("#5272AF" "#2257A0" nil ))
   (magenta    '("#97365b" "#985daa" nil ))
   (violet     '("#842879" "#a9a1e1" nil ))
   (cyan       '("#398eac" "#46D9FF" nil ))
   (dark-cyan  '("#2c7088" "#5699AF" nil ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   black)
   (selection      dark-blue)
   (builtin        teal)
   (comments       (if doom-effy-light-brighter-comments dark-cyan (doom-lighten base5 0.2)))
   (doc-comments   (doom-lighten (if doom-effy-light-brighter-comments dark-cyan base5) 0.25))
   (constants      magenta)
   (functions      teal)
   (keywords       blue)
   (methods        teal)
   (operators      blue)
   (type           mblue)
   (strings        green)
   (variables      violet)
   (numbers        magenta)
   (region         base4)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-effy-light-brighter-modeline)
   (-modeline-pad
    (when doom-effy-light-padded-modeline
      (if (integerp doom-effy-light-padded-modeline) doom-effy-light-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg black
    ;; (if -modeline-bright
    ;;     (doom-darken blue 0.475)
    ;;   `(,(doom-darken (car bg-alt) 0.15) ,@(cdr base0)))
    )
   (modeline-bg-l black
    ;; (if -modeline-bright
    ;;     (doom-darken blue 0.45)
    ;;   `(,(doom-darken (car bg-alt) 0.1) ,@(cdr base0)))
    )
   (modeline-bg-inactive   base3)
   (modeline-bg-inactive-l `(,(car bg-alt) ,@(cdr base1)))
)

  ;; --- extra faces ------------------------
  
  (
   ((line-number &override) :foreground fg-alt)
   ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face
    :foreground comments
    :background (if doom-effy-light-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   ;; powerline
   (powerline-active0 :inherit 'mode-line :foreground bg :background black)
   (powerline-active1 :inherit 'mode-line :foreground bg :background black)
   (powerline-active2 :inherit 'mode-line :foreground bg :background black)
   (powerline-inactive0 :inherit 'mode-line :foreground fg :background base3)
   (powerline-inactive1 :inherit 'mode-line :foreground fg :background base3)
   (powerline-inactive2 :inherit 'mode-line :foreground fg :background base3)

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; helm
   (helm-ff-executable :foreground red)
   (helm-ff-dotted-directory :background grey :foreground black)
   (helm-selection :background grey)
   (helm-source-header :background "dark cyan" :foreground black :weight 'bold :height 1.3)
   (helm-candidate-number :foreground bg :background black)
   (helm-argument-name :foreground bg :background black)

   ;; cursor
   (cursor :background black)

   ;; custom
   (custom-state :foreground cblue)
   (custom-variable-tag :foreground "midnight blue" :weight 'bold)

   ;; dired
   (dired-directory :inherit font-lock-function-name-face :foreground cblue)

   ;; region
   (region :background blue)
   (isearch :background dark-blue)
   ((lazy-highlight &override) :background grey)

   ;; paren
   ((paren-face-match &override) :foreground fg :background blue :weight 'ultra-bold)
   ((paren-face-mismatch &override) :foreground bright-red :background bg :weight 'ultra-bold)
   
   ;; dired
   (dired-mark :inherit font-lock-constant-face)

   ;; org-mode
   (org-hide :foreground hidden)
   (org-headline-done :foreground grey :weight 'bold)
   (org-date :foreground fg :weight 'bold)
   (org-level-1 :background bg :foreground blue :weight 'ultra-bold)
   (org-level-2 :background bg :foreground teal :weight 'extra-bold)
   (org-block   :background (doom-darken bg 0.02))
   (org-block-begin-line :foreground fg-alt :weight 'bold)

   ;; lsp
   (lsp-ui-sideline-code-action :foreground orange)

 ))

;;; doom-effy-light-theme.el ends here
