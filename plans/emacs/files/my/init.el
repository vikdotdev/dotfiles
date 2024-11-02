(setq inhibit-startup-message t)
(pixel-scroll-precision-mode)
(setq meow-expand-hint-remove-delay 0.3)

;; Smooth scroll down with C-v
; (defun smooth-scroll-down ()
  ; (interactive)
  ; (pixel-scroll-precision-interpolate (* 3 (window-line-height)) 'scroll-down-command))
; 
; ;; Smooth scroll up with M-v
; (defun smooth-scroll-up ()
  ; (interactive)
  ; (pixel-scroll-precision-interpolate (* 3 (window-line-height)) 'scroll-up-command))
; 
; ;; Remap C-v and M-v to smooth scrolling functions
; (global-set-key (kbd "C-v") 'smooth-scroll-down)
; (global-set-key (kbd "M-v") 'smooth-scroll-up)


(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun my/meow-reverse-find ()
  "Find backwards."
  (interactive)
  (negative-argument (meow-find)))

;; (defun my/meow-append ()
;;   "Move to the end of selection, switch to INSERT state."
;;   (interactive)
;;   (if meow--temp-normal
;;       (progn
;;         (message "Quit temporary normal mode")
;;         (meow--switch-state 'motion))
;;     (if (not (region-active-p))
;;         (when (and (not (use-region-p))
;;                    (< (point) (point-max)))
;;           (forward-char 1))
;;       (meow--direction-forward)
;;       (meow--cancel-selection))
;;     (meow--switch-state 'insert)))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(setq ring-bell-function 'ignore)

(set-face-attribute 'default nil :font "Iosevka" :height 186)
(load-theme 'tango-dark)


(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'magit)
  (package-install 'magit))

(unless (package-installed-p 'meow)
  (package-install 'meow))

(unless (package-installed-p 'evil)
  (package-install 'evil))

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("'" . repeat)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '(":" . meow-goto-line)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)

   '("a" . meow-append)
   '("i" . meow-insert)
   '("c" . meow-change)
   '("o" . meow-open-below)
   '("O" . meow-open-above)

   '("h" . meow-left-expand)
   '("j" . meow-next-expand)
   '("k" . meow-prev-expand)
   '("l" . meow-right-expand)
 
   '("w" . meow-next-word)
   '("W" . meow-next-symbol)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("q" . meow-mark-word)
   '("Q" . meow-mark-symbol)
   '("f" . meow-find)

   '("g" . meow-cancel-selection)
   '("G" . meow-grab)

   ;; '("o" . meow-block) TODO bind. what is a block?
   ;; '("O" . meow-to-block)

   '("s" . meow-beginning-of-thing)
   '("e" . meow-end-of-thing)

   '("J" . meow-join)
   '("v" . meow-line)
   '("n" . meow-search)

   '("p" . meow-yank)
   '("P" . meow-yank-pop)
   '("y" . meow-save)
   '("d" . meow-kill)
   '("x" . meow-delete)
   '("R" . meow-replace)
   '("r" . undo-redo)
   '("u" . meow-undo)
   '("z" . meow-pop-selection)
   '("<escape>" . ignore)))

(require 'meow)

(unless (package-installed-p 'command-log-mode)
  (package-install 'command-log-mode))
(meow-setup)
(meow-global-mode 1)
(require 'command-log-mode)

(global-command-log-mode 1)
(clm/toggle-command-log-buffer)

(unless (package-installed-p 'vertico)
  (package-install 'vertico))

(vertico-mode 1)

(unless (package-installed-p 'consult)
  (package-install 'consult))

(unless (package-installed-p 'zig-mode)
  (package-install 'zig-mode))

(autoload 'zig-mode "zig-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode))

;; (zig "https://github.com/tree-sitter-grammars/tree-sitter-zig" "master" nil nil nil)
