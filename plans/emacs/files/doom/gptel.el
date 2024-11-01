;;; $DOOMDIR/gptel.el -*- lexical-binding: t; -*-
;;; LLM integration configuration
;;
;; To clear cache use this:
;; (setq auth-source-debug t)
;; (auth-source-forget-all-cached)

(require 'auth-source)
;; (gptel-api-key-from-auth-source "openai.com" "EMACS_API_KEY")

(setq openai-api-key (auth-source-pick-first-password :host "openai.com" :user "EMACS_API_KEY" :secret t))

;; (message "Key: %s" openai-api-key)

(use-package! gptel
  :config
  (setq! gptel-api-key (gptel-api-key-from-auth-source "openai.com" "EMACS_API_KEY")))

(setq gptel-default-mode #'org-mode)

(map! :leader "l n" #'gptel)
(map! :leader "l m" #'gptel-menu)
(map! :leader "l a" #'gptel-add)
(map! :leader "l f" #'gptel-add-file)
(map! :leader "l s" #'gptel-send)
