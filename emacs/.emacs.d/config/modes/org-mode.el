(add-hook 'org-mode-hook
	  'smartparens-mode)
(add-hook 'org-mode-hook
	  'linum-mode)

(setq org-default-notes-file "~/org/Main.org")

;; (defun load-directory (dir)
;;  (let ((load-it (lambda (f) (load-file (concat (file-name-as-directory dir) f)))))
;;    (mapc load-it (directory-files dir nil "\\.el$"))))

(setq org-agenda-files
      (mapcar (lambda (f)
		(concat
		 (file-name-as-directory skeleten/org-files-base-dir) f))
       (directory-files skeleten/org-files-base-dir nil "\\.org$")))
