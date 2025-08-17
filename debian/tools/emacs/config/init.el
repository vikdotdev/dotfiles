(require 'org)

(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi :no-confirm))
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
