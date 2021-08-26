;;; doom-gahag-theme.el
(require 'doom-themes)

(defgroup doom-gahag-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-gahag-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-gahag-theme
  :type 'boolean)

(defcustom doom-gahag-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-gahag-theme
  :type 'boolean)

(defcustom doom-gahag-comment-bg doom-gahag-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their legibility."
  :group 'doom-gahag-theme
  :type 'boolean)

(defcustom doom-gahag-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to determine the exact padding."
  :group 'doom-gahag-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-gahag
  "gahag theme!"

  ;; name        default   256       16
  ((bg         '("#2b2a27" nil       nil            ))
   (bg-alt     '("#282725" nil       nil            )) ;; arbitrarily picked this colour to change hline
   (base0      '("#2b2a27" "black"   "black"        ))
   (base1      '("#1c1f24" "#1e1e1e" "brightblack"  ))
   (base2      '("#202328" "#2e2e2e" "brightblack"  ))
   (base3      '("#23272e" "#262626" "brightblack"  ))
   (base4      '("#3f444a" "#3f3f3f" "brightblack"  ))
   (base5      '("#5B6268" "#525252" "brightblack"  ))
   (base6      '("#73797e" "#6b6b6b" "brightblack"  ))
   (base7      '("#9ca0a4" "#979797" "brightblack"  ))
   (base8      '("#DFDFDF" "#dfdfdf" "white"        ))
   (fg         '("#ede0ce" "#bfbfbf" "brightwhite"  ))
   (fg-alt     '("#5B6268" "#2d2d2d" "white"        ))

   (grey       base5)
   (bright     '("#fBfBfB" "white"   "white"        ))
   (white      '("#f8f8f0" "base4"   "base4"        ))
   (red        '("#ff5d38" "#ff6655" "red"          )) ;; peacock todo 16
   (orange     '("#cb4b16" "#dd8844" "brightred"    ))
   (green      '("#98be65" "#99bb66" "green"        ))
   (teal       '("#26a6a6" "#44b9b1" "brightgreen"  )) ;; peacock
   (yellow     '("#ffad29" "#ECBE7B" "yellow"       )) ;; peacock, todo 16
   (blue       '("#51afef" "#51afef" "brightblue"   ))
   (blue2      '("#0882d6" "#51afef" "brightblue"   ))
   (dark-blue  '("#2257A0" "#2257A0" "blue"         ))
   (magenta    '("#c678dd" "#c678dd" "magenta"      ))
   (violet     '("#a9a1e1" "#a9a1e1" "brightmagenta"))
   (cyan       '("#46D9FF" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("#5699AF" "#5699AF" "cyan"         ))
   (yellow2    '("#ffd73a" "#ECBE7B" "yellow"       ))
   (coral-popup  '("#a60033" "#f6bfbc" "coral-popup"         ))
   (mdline-bg base8)
   (mdline-inactive-bg (doom-lighten bg 0.1))


   ;; face categories -- required for all themes
   (highlight      yellow)
   (vertical-bar   (doom-lighten bg 0.1))
   (selection      grey)
   (builtin        yellow)
   (comments       base6)
   (doc-comments   (doom-lighten base5 0.25)) ;; TODO
   (constants      yellow)        ;; done
   (functions      white)      ;; done
   (keywords       yellow)    ;; done
   (methods        white)      ;; not sure how to test this.
   (operators      yellow)     ;; not showing up on `=` etc.
   (type           blue)       ;;
   (strings        yellow2)
   (variables      white)      ;; done
   (numbers        red)        ;; done

   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base0) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (-modeline-bright doom-gahag-brighter-modeline)
   (-modeline-pad
    (when doom-gahag-padded-modeline
      (if (integerp doom-gahag-padded-modeline) doom-gahag-padded-modeline 4)))

   (modeline-fg     bg)
   (modeline-fg-alt fg)
   (modeline-bg mdline-bg)
   (modeline-bg-l mdline-bg)
   (modeline-bg-inactive mdline-inactive-bg)
   (modeline-bg-inactive-l mdline-inactive-bg))


  ;; --- extra faces ------------------------
  ((cursor :background white)
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ((font-lock-keyword-face &override) :weight 'semi-bold )

   (font-lock-comment-face
    :foreground comments
    :background (if doom-gahag-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground base7)

   ;; tooltip
   (tooltip              :background bg-alt :foreground fg)

   ;; isearch
   (isearch :background yellow2 :foreground bg)
   (lazy-highlight :background yellow :foreground bg)

   ;; helm
   (helm-ff-dotted-directory :foreground (doom-lighten fg 0.5))
   (helm-ff-directory :foreground blue)
   (helm-buffer-modified :foreground yellow)
   (helm-buffer-directory :foreground blue)
   (helm-buffer-file :foreground fg)
   (helm-non-file-buffer :foreground (doom-darken fg 0.5))

   ;; company
   (company-tooltip            :inherit 'tooltip)
   (company-tooltip-common                           :foreground highlight)
   (company-tooltip-search     :background highlight :foreground bg :distant-foreground fg)
   (company-tooltip-selection  :background selection)
   (company-tooltip-mouse      :background magenta   :foreground bg :distant-foreground fg)
   (company-tooltip-annotation                       :foreground violet)
   (company-scrollbar-bg       :inherit 'tooltip)
   (company-scrollbar-fg       :background highlight)
   (company-preview                                  :foreground highlight)
   (company-preview-common     :background base3 :foreground magenta)
   (company-preview-search     :inherit 'company-tooltip-search)
   (company-template-field     :inherit 'match)

   ;; lsp
   (lsp-face-highlight-textual :weight 'bold)
   (lsp-face-highlight-read :weight 'bold)
   (lsp-face-highlight-write :weight 'bold)
   (lsp-ui-sideline-code-action :foreground base7)
   (lsp-modeline-code-actions-face :foreground fg)
   (lsp-ui-sideline-symbol :foreground base7)
   (lsp-ui-sideline-global :foreground base7)
   (lsp-ui-sideline-current-symbol :foreground base7 :weight 'medium)
   (lsp-ui-sideline-symbol-info :foreground base7)
   ;; (lsp-ui-peek-header :background grey)
   ;; (lsp-ui-peek-selection :foreground black :background silver :weight 'medium)
   (lsp-lsp-flycheck-warning-unnecessary-face :background bg)

   ;; magit
   ;; (magit-filename :foreground fg)
   ;; (magit-branch-local :foreground bright-blue)
   ;; (magit-mode-line-process :foreground fg :inherit 'italic)
   ;; (magit-blame-heading :foreground fg :background base3 :weight 'bold)
   ;; (magit-blame-date :foreground red :weight 'medium)
   ;; (magit-diff-file-heading-selection :background selection :foreground silver)
   (magit-diff-file-heading :foreground yellow2 :background bg :weight 'bold)
   (magit-diff-file-heading-highlight :foreground yellow :background bg :weight 'bold)
   (magit-diff-hunk-heading :foreground fg :background base4)
   (magit-diff-hunk-heading-highlight :foreground fg :background base4 :weight 'bold)
   (magit-diff-added :foreground (doom-darken base8 0.1) :background (doom-blend green bg 0.5))
   (magit-diff-added-highlight :foreground (doom-darken base8 0.1) :background (doom-blend green bg 0.5))
   (magit-diff-removed :foreground (doom-darken base8 0.1) :background (doom-blend red bg 0.5))
   (magit-diff-removed-highlight :foreground (doom-darken base8 0.1) :background (doom-blend red bg 0.5))
   (diff-refine-added :foreground white :background (doom-blend green bg 0.5))
   (diff-refine-removed :foreground white :background (doom-blend red bg 0.5))
   ;; (git-commit-overlong-summary :background bg :foreground bright-red)

   ;; popup
   (popup-face :inherit 'tooltip)
   (popup-selection-face :inherit 'tooltip)

   ;; pos-tip
   (popup          :inherit 'tooltip)
   (popup-tip-face :inherit 'tooltip)

   ;; powerline
   (powerline-active0 :inherit 'mode-line :foreground bg :background base8)
   (powerline-active1 :inherit 'mode-line :foreground bg :background base8)
   (powerline-active2 :inherit 'mode-line :foreground bg :background base8)
   (powerline-inactive0 :inherit 'mode-line :foreground fg :background (doom-lighten bg 0.1))
   (powerline-inactive1 :inherit 'mode-line :foreground fg :background (doom-lighten bg 0.1))
   (powerline-inactive2 :inherit 'mode-line :foreground fg :background (doom-lighten bg 0.1))

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-code-face :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-level-1 :background bg :foreground blue :weight 'medium)
   (org-level-2 :background bg :foreground teal :weight 'medium)
   (org-level-3 :background bg :foreground violet :weight 'medium)
   (org-level-4 :background bg :foreground cyan :weight 'medium)
   (org-level-5 :background bg :foreground green :weight 'medium)
   (org-level-6 :background bg :foreground yellow2 :weight 'medium)
   (org-level-7 :background bg :foreground blue2 :weight 'medium)
   (org-level-8 :background bg :foreground magenta :weight 'medium)
   (org-block   :background (doom-darken bg 0.02) :extend t)
   (org-tag     :background bg :foreground bright)
   (org-link :foreground yellow :underline t :weight 'regular)
  )
  ;; --- extra variables ---------------------
  ;; ()
)

;;; doom-gahag-theme.el ends here
