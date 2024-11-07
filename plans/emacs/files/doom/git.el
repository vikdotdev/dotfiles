;;; $DOOMDIR/git.el -*- lexical-binding: t; -*-

(setq git-link-use-commit t)
(setq git-link-use-single-line-number t)

(map! :leader "g y" #'git-link)
