;;; $DOOMDIR/dot.el -*- lexical-binding: t; -*-

(defun dot-insert-timestamp ()
  (interactive)
  (insert (format-time-string "%Y %b %d, %A %H:%M")))

(map! :leader "i t" #'dot-insert-timestamp)

(map! :leader "TAB o" #'+workspace/other)
