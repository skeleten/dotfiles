(add-hook 'org-mode-hook
	  'smartparens-mode)
(add-hook 'org-mode-hook
	  'linum-mode)

(defun skeleten/org/get-org-files ()
  (mapcar (lambda (f)
	    (concat
	     (file-name-as-directory skeleten/org-files-base-dir) f))
	  (directory-files skeleten/org-files-base-dir nil "\\.org$")))

(setq org-default-notes-file "~/org/Main.org"
      org-agenda-files (skeleten/org/get-org-files)
      org-log-done 'time)

