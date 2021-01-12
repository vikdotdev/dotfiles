;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(global-visual-line-mode)

;; (define-key evil-normal-state-map (kbd "g t") 'centaur-tabs-forward)
;; (define-key evil-normal-state-map (kbd "g T") 'centaur-tabs-backward)
;; (setq centaur-tabs-cycle-scope 'tabs)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Viktor Habchak"
      user-mail-address "vikdotdev@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka Curly" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-moonlight)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Repositories/org-docs/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Mappings
;; (map!
;;   :map smartparens-mode-map
;;   ;; smartparens maps (navigation ops)
;;   :nvie "C-M-f" #'sp-forward-sexp
;;   :nvie "C-M-b" #'sp-backward-sexp
;;   :nvie "C-M-u" #'sp-backward-up-sexp
;;   :nvie "C-M-d" #'sp-down-sexp
;;   ;; smartparens maps (split join slurp barf)
;;   :nie "M-s" #'sp-split-sexp
;;   :nie "M-j" #'sp-join-sexp
;;   :nvie "SPC-{" #'sp-backward-slurp-sexp
;;   :nvie "C-}" #'sp-backward-barf-sexp)

(map! :leader
  :prefix "c"
        :desc "Wrap with []" "[" #'sp-wrap-square
        :desc "Wrap with []" "]" #'sp-wrap-square
        :desc "Wrap with {}" "{" #'sp-wrap-curly
        :desc "Wrap with {}" "}" #'sp-wrap-curly
        :desc "Wrap with ()" "(" #'sp-wrap-round
        :desc "Wrap with ()" ")" #'sp-wrap-round
        :desc "Split"        "p" #'sp-split-sexp
        :desc "Join"         "j" #'sp-join-sexp
        :desc "Unwrap"       "u" #'sp-unwrap-sexp)

(map! :leader
  :prefix "t"
  :desc "Toggle comments"  "m" #'hide/show-comments-toggle)

(map! :localleader
      :map ruby-mode-map
      :prefix ("i" . "Inf ruby")
      :desc "Open Inf ruby console" "c" 'inf-ruby-console-auto)

(map! :localleader
      :map dart-mode-map
      :prefix ("e" . "emulator")
      :desc "Hot reload" "h" 'flutter-run-or-hot-reload
      :desc "Performance overlay" "p" 'flutter-performance-overlay
      :desc "Inspector" "i" 'flutter-inspector
      :desc "Screenshot" "s" 'flutter-screenshot
      :desc "Construction lines" "c" 'flutter-construction-lines
      :desc "Quit" "q" 'flutter-quit
      :desc "Hot restart" "r" 'flutter-hot-restart)

(map! :localleader
      :map dart-mode-map
      :prefix ("c" . "code")
      :desc "Apply lsp-ui code action" "a" 'lsp-ui-sideline-apply-code-actions)


(map! :localleader
      :map dart-mode-map
      :prefix ("d" . "docs")
      :desc "focus frame" "f" 'lsp-ui-doc-focus-frame
      :desc "show docs under point" "p" 'lsp-ui-doc-show)

;; (map! :localleader
;;       :map lsp-ui-doc-frame-mode
;;       :prefix ("d" . "docs")
;;       :desc "unfocus frame" "u" 'lsp-ui-doc-unfocus-frame
;;       :desc "show docs under point" "p" 'lsp-ui-doc-show)

(map! :localleader
      :map es-mode-map
      :prefix ("e" . "ElasticSearch")
      :desc "Execute under point" "e" 'es-execute-request-dwim)

;; (map! :localleader
;;       :map ruby-mode-map
;;       :prefix ("b" . "Bundler")
;;       :desc "Open" "o" 'bundle-open
;;       :desc "Install" "i" 'bundle-install)

;; Variables
(setq es-always-pretty-print t)
(setq lsp-dart-sdk-dir "~/Repositories/flutter/bin/cache/dart-sdk")
(setq lsp-dart-flutter-sdk-dir "~/Repositories/flutter")
