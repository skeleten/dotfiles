;;; org-mime-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "org-mime" "org-mime.el" (23145 61027 897722
;;;;;;  494000))
;;; Generated autoloads from org-mime.el

(autoload 'org-mime-htmlize "org-mime" "\
Export a portion of an email to html using `org-mode'.
If called with an active region only export that region, otherwise entire body.
If ARG is not nil, use `org-mime-fixedwith-wrap' to wrap the exported text.

\(fn ARG)" t nil)

(autoload 'org-mime-org-buffer-htmlize "org-mime" "\
Create buffer where text encoded in html&org formats as mime alternatives.

\(fn)" t nil)

(autoload 'org-mime-org-subtree-htmlize "org-mime" "\
Create an email buffer containing the current subtree of the
current org-mode file exported to html and encoded in both html
and in org formats as mime alternatives.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; org-mime-autoloads.el ends here
