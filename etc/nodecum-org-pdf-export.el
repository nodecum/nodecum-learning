(require 'org-pdf)

(setq org-publish-project-alist
      '(("nodecum"
         :base-directory "~/prog/nodecum.org/nodecum-learning/org/"
         :publishing-function org-latex-publish-to-pdf
         :publishing-directory "~/prog/nodecum.org/nodecum-learning/doc/static/books"
	 ))
      )


(defun ext-to-int-link (backend)
  "for latex export turn external file links to org files with :: into internal links"
  (pcase backend
    (`latex
     (goto-char (point-min))
     (while (re-search-forward org-any-link-re nil t)
       (let ((end0 (match-end 0))
	     (beg2 (match-beginning 2))
	     (end2 (match-end 2)))
	 (if beg2
	     (progn
	       (goto-char beg2) ;; the url part
	       (let ((res (re-search-forward "file:.*\\.org::" end2 t)))
		 (goto-char end0)
		 (if res (delete-region (match-beginning 0) (match-end 0)))
		 )
	       )
	   )
	 )
       )
     )
    )
  )


(add-hook 'org-export-before-parsing-hook #'ext-to-int-link)
