;;; $DOOMDIR/dot.el -*- lexical-binding: t; -*-

(defun dot-insert-timestamp ()
  (interactive)
  (insert (format-time-string "%Y %b %d, %A %H:%M")))
