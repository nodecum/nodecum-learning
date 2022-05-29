;; for org-mode files we find the directory which
;; holds the "org" file/directory, this is the
;; root directory of the archive, extended with /doc
;; is the hugo base dir in our case
(
 ("prog" . ((org-mode . ((org-hugo-section . "prog")))))
 ;;("de" . ((org-mode . ((org-hugo-section . "de")))))
 (org-mode . (
	      (eval setq org-hugo-base-dir
		    (concatenate 'string
				 (locate-dominating-file default-directory "org")
				 "/doc"))
	      (eval . (org-hugo-auto-export-mode))
	      ))
 )
