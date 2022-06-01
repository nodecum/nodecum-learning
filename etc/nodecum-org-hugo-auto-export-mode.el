;;; nodecum-org-hugo-auto-export-mode.el --- Minor mode for auto-exporting using ox-hugo -*- lexical-binding: t -*-

;; Authors: Kaushal Modi <kaushal.mod@gmail.com>, Evgeni Kolev <evgenysw@gmail.com>
;; URL: https://ox-hugo.scripter.co

;;; Commentary:
;;
;; This is a minor mode for enabling auto-exporting of Org files via
;; ox-hugo.
;;
;; *It is NOT a stand-alone package.*

;;; Usage:
;;
;; To enable this minor mode for a "content-org" directory, add below
;; to the .dir-locals.el:
;;
;;   (("content-org/"
;;     . ((org-mode . ((eval . (nodecum-org-hugo-auto-export-mode)))))))

;;; Code:


;;;###autoload
(define-minor-mode nodecum-org-hugo-auto-export-mode
  "Toggle auto exporting the Org file using `nodecum-org-hugo-export-buffer'."
  :global nil
  :lighter ""
  (if nodecum-org-hugo-auto-export-mode
      ;; When the mode is enabled
      (progn
        (add-hook 'after-save-hook #'nodecum-org-hugo-export-buffer :append :local))
    ;; When the mode is disabled
    (remove-hook 'after-save-hook #'nodecum-org-hugo-export-buffer :local)))


(provide 'nodecum-org-hugo-auto-export-mode)

