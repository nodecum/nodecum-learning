;; for org-mode files we find the directory which
;; holds the "org" file/directory, this is the
;; hugo base dir in our case
(
 ("en" . ((org-mode . ((org-hugo-section . "en")))))
 ("de" . ((org-mode . ((org-hugo-section . "de")))))
 (org-mode . (
	      (eval setq org-hugo-base-dir
		    (locate-dominating-file default-directory "org"))
	      (eval . (org-hugo-auto-export-mode))
	      ))
 )
