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
;; (setq doom-font (font-spec :family "Iosevka Curly" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-miramare)
;; (setq doom-theme 'doom-nova)
;; (setq doom-theme 'doom-dark+)
(setq doom-theme 'vikdotdev-dracula)
;; (setq doom-theme 'doom-dracula)
;; (setq doom-theme 'doom-dracula-vikdotdev)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Repositories/docs/")

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

(map! "C-`" nil)
(map! "C-`" #'+popup/raise)

;; (map! :localleader
;;       :map ruby-mode-map
;;       :prefix ("b" . "Bundler")
;;       :desc "Open" "o" 'bundle-open
;;       :desc "Install" "i" 'bundle-install)

;; Variables
(setq es-always-pretty-print t)
(setq lsp-dart-sdk-dir "~/Repositories/flutter/bin/cache/dart-sdk")
(setq lsp-dart-flutter-sdk-dir "~/Repositories/flutter")
(setq-default default-input-method 'ukrainian-computer)

(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)))

(add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)
;; this one should be included by tty package in init.el
(use-package! evil-terminal-cursor-changer
  :hook (tty-setup . evil-terminal-cursor-changer-activate))



(defun rcd/dired-view ()
  "View files, either as HTML or media"
  (interactive)
  (let* ((files (dired-get-marked-files))
     (how-many (length files))
     (extensions (mapcar 'file-name-extension files))
     (extensions (mapcar 'downcase extensions)))
(cond ((member "html" extensions) (eww-open-file (car files)))
      ((member "mp4" extensions) (emms-play-dired))
      ((member "mp3" extensions) (emms-play-dired))
      ((member "ogg" extensions) (emms-play-dired))
      (t (if (> how-many 1) (xdg-open-files files)
	   (xdg-open (car files) t))))))

(defun xdg-open (file &optional async)
  "Opens file with xdg-open. Without optional argument ASYNC, it will wait for the file to finish playing or review."
  (let ((command (format "xdg-open '%s'" file)))
(if async
    (async-shell-command command)
  (shell-command command))))

(defun xdg-open-files (files)
  "Opens list of files with xdg-open one by one, waiting for each to finish."
  (dolist (file files)
(xdg-open file)))

;; Finally mapping the key V to dired-mode-map

(map! :map dired-mode-map
           :g "C-c o"  'rcd/dired-view)

(add-hook 'after-init-hook 'inf-ruby-switch-setup)
