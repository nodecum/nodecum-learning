(defun export-file-to-hugo (fpath)
  "load the file and export it to md"
  (let (mybuffer)
    (setq mybuffer (find-file fpath))
    (org-hugo-export-to-md)
    (kill-buffer mybuffer)))

(require 'f)

(mapc 'export-file-to-hugo
      (flatten-tree
       (mapcar
	(lambda (dir) 
	  (f-files dir
		   (lambda (file)
		     (equal (concat (f-no-ext file) ".org") file)))
	  )
	(let (this-dir)
	  (setq this-dir (f-dirname (f-this-file)))
	  (nconc
	   (list this-dir)
	   (f-directories this-dir (lambda (file) (not (f-symlink? file))))
	   )
	  )
	)
       )
      )
 
