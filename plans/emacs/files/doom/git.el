;;; $DOOMDIR/git.el -*- lexical-binding: t; -*-

(setq git-link-use-commit t)

(map! :leader "g y" #'git-link)
