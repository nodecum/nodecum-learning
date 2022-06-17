#! /bin/sh
":"; exec emacs --script "$0" -- "$@" # -*- mode:emacs-lisp -*-

(require 'package)
(package-initialize)

(require 'f)

;; add directory which contains this file to the load path
(add-to-list 'load-path (f-dirname load-file-name))

(require 'nodecum-org-hugo-export) 
(require 'ob-svgbob)
;; we do not allow local variables
(setq enable-local-variables nil)

(nodecum-org-hugo-export-dir (nth 1 argv))
