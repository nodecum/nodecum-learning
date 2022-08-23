(require 'f)
(require 'ox-hugo)
(require 'org-pdf)

(defun nodecum-org-hugo-export-buffer ()
  "export the current buffer to hugo, setting hugo base dir
 by getting up to 'org' dir and looking for 'doc' dir."
  (interactive)
  ;; we do not export if the buffer is the main file
  (if (not (equal (f-no-ext (f-no-ext (f-filename buffer-file-name) ) ) "main")) 
      ;; set the hugo base dir searching up the diretory hierarchy
      ;; for finding dir 'org', then try to find subdir 'doc'
      ;; which is then the base dir.
      (let (org-dom-dir doc-dir file-base)
	(setq file-base (f-no-ext buffer-file-name))
	(if (not (equal (concat file-base ".org") buffer-file-name))
	    (user-error
	     "Error: current buffer file ends not on '.org'")) 
	(setq org-dom-dir (locate-dominating-file buffer-file-name "org"))
	(if (null org-dom-dir) (user-error
				"Error: could not find a directory named 'org' 
		        by going upwards the diretory hierarchy"))
	(setq doc-dir (concat org-dom-dir "doc"))
	(if (f-dir? doc-dir)
	    (setq org-hugo-base-dir doc-dir)
	  (user-error
	   "Error: could not find a diretory named 'doc' on same dir
        level as 'org' diretory was found")
	  )
	;; set the hugo section which is determined
	;; from the relative path to the top org dir
	(setq org-hugo-default-section-directory
	      (f-dirname (f-relative buffer-file-name (concat org-dom-dir "org"))))
	(if (equal org-hugo-default-section-directory "./")
	    (setq org-hugo-default-section-directory "/"))
	;; if we have an .de.org file and it exists an
	;; corresponding .en.org file than set the library of babel
	;; to the .en.org file to allow refering to the en code blocks.
	(if (equal (f-ext file-base) "de")
	    (let (fpath-en)
	      (setq fpath-en (concat (f-swap-ext file-base "en") ".org"))
	      (if (f-file? fpath-en)
		  (org-babel-lob-ingest fpath-en))
	      )
	  )
	;; disable auto copying
	(setq org-hugo-external-file-extensions-allowed-for-copying (list "svg" "pdf"))
	(org-hugo-export-wim-to-md :all-subtrees)
	)
    )
  )

(defun nodecum-org-hugo-export-file (fpath)
  "load the file and export it to md"
  (let (mybuffer result base-dir)
    ;; load the org file
    (setq mybuffer (find-file fpath))
    (setq result (nodecum-org-hugo-export-buffer))
    (setq base-dir org-hugo-base-dir)
    (kill-buffer mybuffer)
    (mapc
     (lambda (result-file)
       (if (stringp result-file)
	   ;; return the name of the exported file
	   (message "exported %s -> %s" (f-filename fpath)
		    (f-relative result-file base-dir)))
       )
     result
     )
    )
  )

;; (nodecum-org-hugo-export-file "~/prog/nodecum.org/nodecum-learning/org/env/_index.de.org")

(defun nodecum-org-hugo-export-dir (org-dir)
  "export all files in and below the given directory to hugo"
  (interactive)
  (mapc
   'nodecum-org-hugo-export-file
   (flatten-tree
    (mapcar
     (lambda (dir) 
       (f-files dir
		(lambda (file)
		  (equal (concat (f-no-ext file) ".org") file)))
       )
     (nconc
      (list org-dir)
      (f-directories org-dir (lambda (file) (not (f-symlink? file))))
      )
     )
    )
   )
  )
 
(provide 'nodecum-org-hugo-export)
