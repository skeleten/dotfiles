(add-to-list 'load-path
	     "/usr/share/emacs/site-lisp/mu4e")
(require 'mu4e)
;; Not sure what :match-func does or why it is relevant :(
(setq mu4e-contexts
      `( ,(make-mu4e-context
	   :name "skeleten"
	   :match-func (lambda (msg)
			 (when msg
			   (string-prefix-p "/skeleten" (mu4e-message-field msg :maildir))))
	 :vars '(
		 (mu4e-trash-folder . "/skeleten/Trash")
		 (mu4e-refile-folder . "/skeleten/Archive")
		 (mu4e-sent-folder . "/skeleten/Sent")
		 ))
	 ,(make-mu4e-context
	   :name "VKM"
	   :match-func (lambda (msg)
			 (when msg
			   (string-prefix-p "/VKM" (mu4e-message-field msg :maildir))))
	   :vars '(
		   (mu4e-trash-folder . "/VKM/Deleted Items")
		   (mu4e-refile-folder . "/VKM/Archive")
		   (mu4e-sent-func . "/VKM/Sent Items")
		   ))
	 ))
;; Bookmarks for mu4e; They go to searches
;; b <key> to jump to them
(setq mu4e-bookmarks
      `(,(make-mu4e-bookmark
	   :name "VKM"
	   :query "maildir:\"/VKM/INBOX*\" AND NOT flag:trashed"
	   :key ?v)
	,(make-mu4e-bookmark
	  :name "Privat"
	  :query "maildir:\"/skeleten/INBOX*\" AND NOT flag:trashed"
	  :key ?p)
	,(make-mu4e-bookmark
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
	   :key ?w)))
(setq user-full-name "Jan Pelle Thomson"
      user-mail-address "me@skeleten.me")

(setq smtpmail-default-smtp-server "mail.skeleten.me"
      smtpmail-smtp-server "mail.skeleten.me"
      smtpmail-smtp-service 587
      smtpmail-smtp-user "me@skeleten.me"
      smtpmail-local-domain "skeleten.me")

(setq mu4e-get-mail-command "offlineimap")

(defvar my-mu4e-account-alist
  '(("skeleten"
     (mu4e-sent-folder "/skeleten/Sent")
     (user-mail-address "me@skeleten.me")
     (smtpmail-smtp-user "me@skeleten.me")
     (smtpmail-local-domain "skeleten.me")
     (smtpmail-default-smtp-server "mail.skeleten.me")
     (smtpmail-smtp-server "mail.skeleten.me")
     (smtpmail-smtp-service 587))
    ("VKM"
     (mu4e-sent-folder "/VKM/Sent")
     (user-mail-address "thomson@vkm.tu-darmstadt.de")
     (smtpmail-smtp-user "thomson")
     (smtpmail-local-domain "vkm.tu-darmstadt.de")
     (smtpmail-default-smtp-server "mail.vkm.tu-darmstadt.de")
     (smtpmail-smtp-server "mail.vkm.tu-darmstadt.de")
     (smtpmail-smtp-service 587))))

(defun my-mu4e-set-account ()
  "Set the account for composing a message.
   This function is taken from: 
     https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html"
  (let* ((account
    (if mu4e-compose-parent-message
        (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
    (string-match "/\\(.*?\\)/" maildir)
    (match-string 1 maildir))
      (mu4e-context-name (mu4e-context-current))))
   (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
  (mapc #'(lambda (var)
      (set (car var) (cadr var)))
        account-vars)
  (error "No email account found"))))

(setq mu4e-headers-date-format "%Y-%m-%d"
      mu4e-use-fancy-chars t
      mu4e-view-show-images t
      mu4e-headers-fields '((:human-date . 12)
			    (:flags . 6)
			    (:from . 22)
			    (:subject)))
(setq mu4e-marks
    '((refile
	:char ("r" . "▶")
	:prompt "refile"
	:dyn-target (lambda (target msg) (mu4e-get-refile-folder msg))
	:action (lambda (docid msg target) (mu4e~proc-move docid
						  (mu4e~mark-check-target target) "-N")))
       (delete
	 :char ("D" . "⊠")
	 :prompt "Delete"
	 :show-target (lambda (target) "delete")
	 :action (lambda (docid msg target) (mu4e~proc-remove docid)))
       (flag
	 :char ("+" . "✚")
	 :prompt "+flag"
	 :show-target (lambda (target) "flag")
	 :action (lambda (docid msg target) (mu4e~proc-move docid nil "+F-u-N")))
       (move
	 :char ("m" . "▷")
	 :prompt "move"
	 :ask-target  mu4e~mark-get-move-target
	 :action (lambda (docid msg target) (mu4e~proc-move docid
					      (mu4e~mark-check-target target) "-N")))
       (read
	 :char    ("!" . "◼")
	 :prompt "!read"
	 :show-target (lambda (target) "read")
	 :action (lambda (docid msg target) (mu4e~proc-move docid nil "+S-u-N")))
       (trash
	 :char ("d" . "▼")
	 :prompt "dtrash"
	 :dyn-target (lambda (target msg) (mu4e-get-trash-folder msg))
	 :action (lambda (docid msg target) (mu4e~proc-move docid
					      (mu4e~mark-check-target target) "+T-N")))
       (unflag
	 :char    ("-" . "∷")
	 :prompt "-unflag"
	 :show-target (lambda (target) "unflag")
	 :action (lambda (docid msg target) (mu4e~proc-move docid nil "-F-N")))
       (untrash
	 :char   ("=" . "▲")
	 :prompt "=untrash"
	 :show-target (lambda (target) "untrash")
	 :action (lambda (docid msg target) (mu4e~proc-move docid nil "-T")))
       (unread
	 :char    ("?" . "◻")
	 :prompt "?unread"
	 :show-target (lambda (target) "unread")
	 :action (lambda (docid msg target) (mu4e~proc-move docid nil "-S+u-N")))
       (unmark
	 :char  " "
	 :prompt "unmark"
	 :action (mu4e-error "No action for unmarking"))
       (action
	 :char ( "a" . "◯")
	 :prompt "action"
	 :ask-target  (lambda () (mu4e-read-option "Action: " mu4e-headers-actions))
	 :action  (lambda (docid msg actionfunc)
		    (save-excursion
		      (when (mu4e~headers-goto-docid docid)
			(mu4e-headers-action actionfunc)))))
       (something
	 :char  ("*" . "✱")
	 :prompt "*something"
	 :action (mu4e-error "No action for deferred mark"))))

(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
