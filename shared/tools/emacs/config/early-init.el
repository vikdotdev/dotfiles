;;; early-init.el --- Early Init File -*- lexical-binding: t -*-

;; Set dark background early to prevent white flash
(setq mode-line-format nil)
(set-face-attribute 'default nil :background "#000000" :foreground "#ffffff")
(push '(background-color . "#000000") default-frame-alist)
(push '(foreground-color . "#ffffff") default-frame-alist)

;;; early-init.el ends here