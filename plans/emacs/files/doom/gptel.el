;;; $DOOMDIR/gptel.el -*- lexical-binding: t; -*-
;;; LLM integration configuration

(require 'auth-source)

(setq openai-api-key (auth-source-pick-first-password :host "openai.com" :user "EMACS_API_KEY" :secret t))

(use-package! gptel
  :config
  (setq! gptel-api-key 'openai-api-key))
