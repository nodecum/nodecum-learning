;; if any org file under this directry is saved,
;; it gets exported to hugo
(
 (org-mode . ((eval . (nodecum-org-hugo-auto-export-mode))))
 )
