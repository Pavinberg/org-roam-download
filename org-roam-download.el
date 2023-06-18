;;; org-roam-download.el -- Org roam download to manage images
;;; Commentary:
;;;    

;;; Code:

(require 'org-roam)
(require 'org-download)

(defcustom org-download-heading-lvl nil
  "Heading level to be used in `org-download--dir-2'."
  :type
  '(choice integer (const :tag "None" nil)))
(make-variable-buffer-local 'org-download-heading-lvl)

(when *is-a-mac* (setq org-download-screenshot-method "screencapture"))
;; (setq org-download-heading-lvl nil)

(defgroup org-roam-download nil
  "Image drag-and-drop for `org-roam`'."
  :group 'org-download
  :prefix "org-roam-download-")

(defun org-roam-download-create-image-dir ()
  "Create image directory for current org-roam node."
  (interactive)
  (let ((dirname (concat org-roam-download-image-dir (org-roam-id-at-point))))
	(unless (file-directory-p dirname)
	  (make-directory dirname))
	dirname))

(with-eval-after-load "org-roam"
  (setq org-roam-download-image-dir (concat org-roam-directory "images/")))

(defun org-roam-download-yank ()
  "Call `org-download-yank' after setting correct directory."
  (interactive)
  (setq org-download-image-dir (org-roam-download-create-image-dir))
  (org-download-yank))

(defun org-roam-download-clipboard ()
  "Call `org-download-yank' after setting correct directory."
  (interactive)
  (setq org-download-image-dir (org-roam-download-create-image-dir))
  (org-download-clipboard))

(provide 'org-roam-download)

;;; org-roam-download.el ends here

