(require 'ol)
(require 'f)

;;;###autoload
(defun org-pdf-export (link description format)
  "Export the pdfview LINK with DESCRIPTION for FORMAT from Org files."
  (let* (path loc page)
    (if (string-match "\\(.+\\)::\\(.*\\)" link)
        (progn
          (setq path (match-string 1 link))
          (setq loc (match-string 2 link))
          (if (string-match "\\([0-9]+\\)++\\(.*\\)" loc)
              (setq page (match-string 1 loc))
            (setq page loc)))
      (setq path link))
    (setq path (org-link-escape path))    
    (cond ((eq format 'md)
           (format
            "[%s](%s#page=%s)"
            description
	    ;; special handling of "static" dir a la ox-hugo
	    (if	(string-match "/static/" path)
		(concat "/" (substring path (match-end 0) ))
	      )
            page
            ))
	  ((eq format 'html)
           (format
            "<a href=\"%s#page=%s\">%s</a>"
            path
            page
            description))
          ((eq format 'latex)
           (format
            "\\href[page=%s]{%s}{%s}"
            page
	    ;; we use only the filename, assuming that the referenced
	    ;; document is in the same folder like the document which
	    ;; contains the link
	    (f-filename path) 
	    description))
          ((eq format 'ascii)
           (format "%s (%s)" description path))
          (t path))))

(org-link-set-parameters "pdf"
			 :export #'org-pdf-export)

(provide 'org-pdf)

