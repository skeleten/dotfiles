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
(setq user-full-name "Jan Pelle Thomson")
(setq user-mail-address "me@skeleten.me")
