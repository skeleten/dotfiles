(add-to-list 'load-path
	     "/usr/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(setq mu4e-contexts
      `( ,(make-mu4e-context
	   :name "skeleten"
	   :match-func (lambda (msg)
			 (when msg
			   (string-prefix-p "/skeleten" (mu4e-message-field msg :maildir))))
	   :vars `(
		   (mu4e-trash-folder . "/skeleten/Trash")
		   )
	   )
	 ,(make-mu4e-context
	   :name "VKM"
	   :match-func (lambda (msg)
			 (when msg
			   (string-prefix-p "/VKM" (mu4e-message-field msg :maildir))))
	   :vars `(
		   (mu4e-trash-folder . "/VKM/Trash")
		   )
	   )))
(setq mu4e-bookmarks
       `( ,(make-mu4e-bookmark
     	:name  "Unread messages"
     	:query "flag:unread AND NOT flag:trashed"
     	:key ?u)
          ,(make-mu4e-bookmark
     	:name "Today's messages"
     	:query "date:today..now AND NOT flag:trashed"
     	:key ?t)
          ,(make-mu4e-bookmark
     	:name "Last 7 days"
     	:query "date:7d..now AND NOT flag:trashed"
     	:key ?w)
	  ))
(setq user-full-name "Jan Pelle Thomson"
      user-mail-address "me@skeleten.me"
      smtpmail-default-smtp-server "mail.skeleten.me"
      smtpmail-smtp-server "mail.skeleten.me"
      smtpmail-smtp-service 587
      smtpmail-smtp-user "me@skeleten.me"
      smtpmail-local-domain "skeleten.me")

