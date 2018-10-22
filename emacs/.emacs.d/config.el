(defvar skeleten/font nil
  "Font to use in buffers")
(defvar skeleten/theme nil
  "Theme to load or 'none to skip")
(defvar skeleten/org-files-base-dir ""
  "Base directory of org files")

(defvar skeleten/java/backend nil
  "Completion backend for java. One of: `eclipse', `intellij'")

(setq skeleten/font "Fira Code 12"
      skeleten/setup-fira-code-ligatures t)
(setq skeleten/theme 'gruvbox-dark-hard)	; Possible  values currently are:
						;  'doom - for the Doom
						;  'moe-dark or 'moe-light for the moe
						; themes
						;  'none - for no theme
						;  everything else will be interpretet as
						; a theme name and trying to get loaded
						; via `load-theme'
(setq skeleten/org-files-base-dir "~/org")

;; add our custom themes to to be loaded
(add-to-list 'custom-theme-load-path
	     "~/.emacs.d/themes")
(add-to-list 'load-path
	     "~/.emacs.d/modes")

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(defun skeleten/load-theme ()
  "Load and set up the theme"
  (interactive)
  (if (boundp 'skeleten/theme)
      (pcase skeleten/theme
	('doom (progn
		 (require 'doom-themes)
		 (setq doom-themes-enable-bold t
		       doom-themes-enable-italic t)
		 (load-theme 'doom-one t)
		 (doom-themes-visual-bell-config)
		 (doom-themes-neotree-config)))
	('doom-safe (progn
		      (require 'doom-themes)
		      (setq doom-themes-enable-bold t
			    doom-themes-enable-italic t)
		      (load-theme 'doom-molokai t)
		      (doom-themes-visual-bell-config)))
	('moe-dark (progn
		     (require 'moe-theme)
		     (setq custom-safe-themes 't)
		     (load-theme 'moe-dark)))
	('moe-light (progn
		     (require 'moe-theme)
		     (setq custom-safe-themes 't)
		     (load-theme 'moe-dark)))
	('none nil)
	(other (progn
		 (setq custom-safe-themes 't)
		 (load-theme other))))
    (error "skeleten/theme unbound")))
(defun skeleten/load-font ()
  "Load and set up the font"
  (interactive)
  (set-face-attribute 'default nil :font skeleten/font)
  (set-frame-font skeleten/font nil t)
  (set-default-font skeleten/font)
  (add-to-list 'default-frame-alist
	     `(font . ,skeleten/font)))
;; run it
(if (daemonp)
    (add-hook 'after-make-frame-functions
	      (lambda (frm)
		(with-selected-frame frm
		  (skeleten/load-theme)
		  (skeleten/load-font))))
  (skeleten/load-theme)
  (skeleten/load-font))

(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

;;; Fira code
;; This works when using emacs --daemon + emacsclient
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))
;; This works when using emacs without server/client
(set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")
;; I haven't found one statement that makes both of the above situations work, so I use both for now

(defconst fira-code-font-lock-keywords-alist
  (mapcar (lambda (regex-char-pair)
	    `(,(car regex-char-pair)
	      (0 (prog1 ()
		   (compose-region (match-beginning 1)
				   (match-end 1)
				   ;; The first argument to concat is a string containing a literal tab
				   ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
	  '(("\\(www\\)"                   #Xe100)
	    ("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
	    ("\\(\\*\\*\\*\\)"             #Xe102)
	    ("\\(\\*\\*/\\)"               #Xe103)
	    ("\\(\\*>\\)"                  #Xe104)
	    ("[^*]\\(\\*/\\)"              #Xe105)
	    ("\\(\\\\\\\\\\)"              #Xe106)
	    ("\\(\\\\\\\\\\\\\\)"          #Xe107)
	    ("\\({-\\)"                    #Xe108)
	    ("\\(\\[\\]\\)"                #Xe109)
	    ("\\(::\\)"                    #Xe10a)
	    ("\\(:::\\)"                   #Xe10b)
	    ("[^=]\\(:=\\)"                #Xe10c)
	    ("\\(!!\\)"                    #Xe10d)
	    ("\\(!=\\)"                    #Xe10e)
	    ("\\(!==\\)"                   #Xe10f)
	    ("\\(-}\\)"                    #Xe110)
	    ("\\(--\\)"                    #Xe111)
	    ("\\(---\\)"                   #Xe112)
	    ("\\(-->\\)"                   #Xe113)
	    ("[^-]\\(->\\)"                #Xe114)
	    ("\\(->>\\)"                   #Xe115)
	    ("\\(-<\\)"                    #Xe116)
	    ("\\(-<<\\)"                   #Xe117)
	    ("\\(-~\\)"                    #Xe118)
	    ("\\(#{\\)"                    #Xe119)
	    ("\\(#\\[\\)"                  #Xe11a)
	    ("\\(##\\)"                    #Xe11b)
	    ("\\(###\\)"                   #Xe11c)
	    ("\\(####\\)"                  #Xe11d)
	    ("\\(#(\\)"                    #Xe11e)
	    ("\\(#\\?\\)"                  #Xe11f)
	    ("\\(#_\\)"                    #Xe120)
	    ("\\(#_(\\)"                   #Xe121)
	    ("\\(\\.-\\)"                  #Xe122)
	    ("\\(\\.=\\)"                  #Xe123)
	    ("\\(\\.\\.\\)"                #Xe124)
	    ("\\(\\.\\.<\\)"               #Xe125)
	    ("\\(\\.\\.\\.\\)"             #Xe126)
	    ("\\(\\?=\\)"                  #Xe127)
	    ("\\(\\?\\?\\)"                #Xe128)
	    ("\\(;;\\)"                    #Xe129)
	    ("\\(/\\*\\)"                  #Xe12a)
	    ("\\(/\\*\\*\\)"               #Xe12b)
	    ("\\(/=\\)"                    #Xe12c)
	    ("\\(/==\\)"                   #Xe12d)
	    ("\\(/>\\)"                    #Xe12e)
	    ("\\(//\\)"                    #Xe12f)
	    ("\\(///\\)"                   #Xe130)
	    ("\\(&&\\)"                    #Xe131)
	    ("\\(||\\)"                    #Xe132)
	    ("\\(||=\\)"                   #Xe133)
	    ("[^|]\\(|=\\)"                #Xe134)
	    ("\\(|>\\)"                    #Xe135)
	    ("\\(\\^=\\)"                  #Xe136)
	    ("\\(\\$>\\)"                  #Xe137)
	    ("\\(\\+\\+\\)"                #Xe138)
	    ("\\(\\+\\+\\+\\)"             #Xe139)
	    ("\\(\\+>\\)"                  #Xe13a)
	    ("\\(=:=\\)"                   #Xe13b)
	    ("[^!/]\\(==\\)[^>]"           #Xe13c)
	    ("\\(===\\)"                   #Xe13d)
	    ("\\(==>\\)"                   #Xe13e)
	    ("[^=n]\\(=>\\)"                #Xe13f)
	    ("\\(=>>\\)"                   #Xe140)
	    ("\\(<=\\)"                    #Xe141)
	    ("\\(=<<\\)"                   #Xe142)
	    ("\\(=/=\\)"                   #Xe143)
	    ("\\(>-\\)"                    #Xe144)
	    ("\\(>=\\)"                    #Xe145)
	    ("\\(>=>\\)"                   #Xe146)
	    ("[^-=]\\(>>\\)"               #Xe147)
	    ("\\(>>-\\)"                   #Xe148)
	    ("\\(>>=\\)"                   #Xe149)
	    ("\\(>>>\\)"                   #Xe14a)
	    ("\\(<\\*\\)"                  #Xe14b)
	    ("\\(<\\*>\\)"                 #Xe14c)
	    ("\\(<|\\)"                    #Xe14d)
	    ("\\(<|>\\)"                   #Xe14e)
	    ("\\(<\\$\\)"                  #Xe14f)
	    ("\\(<\\$>\\)"                 #Xe150)
	    ("\\(<!--\\)"                  #Xe151)
	    ("\\(<-\\)"                    #Xe152)
	    ("\\(<--\\)"                   #Xe153)
	    ("\\(<->\\)"                   #Xe154)
	    ("\\(<\\+\\)"                  #Xe155)
	    ("\\(<\\+>\\)"                 #Xe156)
	    ("\\(<=\\)"                    #Xe157)
	    ("\\(<==\\)"                   #Xe158)
	    ("\\(<=>\\)"                   #Xe159)
	    ("\\(<=<\\)"                   #Xe15a)
	    ("\\(<>\\)"                    #Xe15b)
	    ("[^-=]\\(<<\\)"               #Xe15c)
	    ("\\(<<-\\)"                   #Xe15d)
	    ("\\(<<=\\)"                   #Xe15e)
	    ("\\(<<<\\)"                   #Xe15f)
	    ("\\(<~\\)"                    #Xe160)
	    ("\\(<~~\\)"                   #Xe161)
	    ("\\(</\\)"                    #Xe162)
	    ("\\(</>\\)"                   #Xe163)
	    ("\\(~@\\)"                    #Xe164)
	    ("\\(~-\\)"                    #Xe165)
	    ("\\(~=\\)"                    #Xe166)
	    ("\\(~>\\)"                    #Xe167)
	    ("[^<]\\(~~\\)"                #Xe168)
	    ("\\(~~>\\)"                   #Xe169)
	    ("\\(%%\\)"                    #Xe16a)
	   ;; ("\\(x\\)"                   #Xe16b) This ended up being hard to do properly so i'm leaving it out.
	    ("[^:=]\\(:\\)[^:=]"           #Xe16c)
	    ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
	    ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

(defun add-fira-code-symbol-keywords ()
  (when window-system
    (font-lock-add-keywords nil fira-code-font-lock-keywords-alist)))

(add-hook 'prog-mode-hook
	  #'add-fira-code-symbol-keywords)

(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(defun skeleten/define-global-key (key desc command)
  "Bind a key to the global key map with an description"
  (global-set-key (kbd key) command)
  (which-key-add-key-based-replacements key desc))
(defun skeleten/define-global-prefix (pref desc)
  "Define a description for a global prefix"
  (which-key-add-prefix-title pref desc))

(defun skeleten/define-global-keys (list)
  "Define a list of Key description and commands to the global keymap."
  (if (consp list)
      (let ((key (car list))
	    (desc (car (cdr list)))
	    (command (car (cdr (cdr list))))
	    (rest (cdr (cdr (cdr list)))))
	(skeleten/define-global-key key desc command)
	(skeleten/define-global-keys rest))))

(global-unset-key (kbd "M-m"))

(skeleten/define-global-keys
 '("C-s"	"Search"			swiper
   "M-x"	"M-x"				counsel-M-x
   "C-x C-f"	"Find file"			counsel-find-file
   "C-h f"	"Describe function"		counsel-describe-function
   "C-h k"	"Describe key"			describe-key
   "C-x b"	"Switch buffer"			switch-to-buffer
   ))

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-<") 'mc/mark-next-like-this)
(global-set-key (kbd "C->") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key [?\M-\t] 'company-complete)
(global-set-key [?\C-\t] 'company-complete)

(global-set-key (kbd "C-x g") 'magit-status)

(skeleten/define-global-prefix "M-m m" "Mail")
(skeleten/define-global-keys
 '("M-m m o"    "Open Email interface"          mu4e
   "M-m m u"    "Update email and index"        mu4e-update-mail-and-index))

(skeleten/define-global-prefix "M-m o" "Org mode")
(skeleten/define-global-keys
 '("M-m o a"    "Open Org Agenda"       org-agenda
   "M-m o e"	"Evaluate SRC-block"	org-babel-execute-src-block))

(global-set-key (kbd "M-n") 'er/expand-region)
(skeleten/define-global-key "M-m c" "Compile" 'compile)
(skeleten/define-global-keys
 '("M-m s"      "Jump to char on screen"        ace-jump-char-mode
   "C-."        "Toggle folding"                origami-toggle-node))
(skeleten/define-global-key "M-m f f" "Find file in Project"
			    'fiplr-find-file)
(skeleten/define-global-key "C-S-i" "Open iMenu"
			    'imenu)

(skeleten/define-global-key "M-m f t" "Toggle Treemacs"
			    'treemacs)

(eval-after-load 'java
  '(define-key java-mode-map (kbd "C-s-i") 'lsp-ui-imenu))

(eval-after-load 'lsp-ui
  '(progn (define-key lsp-ui-mode-map
	    [remap xref-find-definitions]
	    #'lsp-ui-peek-find-definitions)
	  (define-key lsp-ui-mode-map
	    [remap xref-find-references]
	    #'lsp-ui-peek-find-references)
	  (define-key lsp-ui-mode-map
	    [remap imenu]
	    #'lsp-ui-imenu)))

(require 'smartparens-config)

(setq company-idle-delay 2)
(setq company-tooltip-align-annotations t)
(setq company-minimum-prefix-length 0)

(setq jdee-server-dir "~/.jars")

(add-to-list 'load-path
	     "/usr/share/emacs/site-lisp/mu4e")
(require 'org-mu4e)
(require 'mu4e)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq mu4e-update-interval 60)

(mu4e-alert-set-default-style 'libnotify)
(mu4e-alert-enable-mode-line-display)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)

(setq mu4e-contexts
      `( ,(make-mu4e-context
	   :name "skeleten"
	   :match-func (lambda (msg)
			 (when msg
			   (string-prefix-p "/skeleten" (mu4e-message-field msg :maildir))))
	   :vars '((mu4e-trash-folder . "/skeleten/Trash")
		   (mu4e-refile-folder . "/skeleten/Archive")
		   (mu4e-sent-folder . "/skeleten/Sent")))
	 ,(make-mu4e-context
	   :name "VKM"
	   :match-func (lambda (msg)
			 (when msg
			   (string-prefix-p "/VKM" (mu4e-message-field msg :maildir))))
	   :vars '((mu4e-trash-folder . "/VKM/Deleted Items")
		   (mu4e-refile-folder . "/VKM/Archive")
		   (mu4e-sent-folder . "/VKM/Sent Items")))
	 ))
;; Bookmarks for mu4e; They go to searches
;; b <key> to jump to them
(setq user-full-name "Jan Pelle Thomson"
      user-mail-address "me@skeleten.me")

;; (setq smtpmail-default-smtp-server "mail.skeleten.me"
;;       smtpmail-smtp-server "mail.skeleten.me"
;;       smtpmail-smtp-service 587
;;       smtpmail-smtp-user "me@skeleten.me"
;;       smtpmail-local-domain "skeleten.me")

;;  (setq mu4e-get-mail-command "offlineimap")

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
     (mu4e-sent-folder "/VKM/Sent Items")
     (user-mail-address "thomson@vkm.tu-darmstadt.de")
     (smtpmail-smtp-user "thomson")
     (smtpmail-local-domain "vkm.tu-darmstadt.de")
     (smtpmail-default-smtp-server "mail.vkm.tu-darmstadt.de")
     (smtpmail-smtp-server "mail.vkm.tu-darmstadt.de")
     (smtpmail-smtp-service 587))
    ))

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
		  (message "set " (car var) " to " (cadr var))
		  (set (car var) (cadr var)))
	      account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

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

(setq mu4e-headers-date-format "%Y-%m-%d"
      mu4e-use-fancy-chars nil
      mu4e-view-show-images t
      mu4e-headers-fields '((:human-date . 12)
			    (:flags . 6)
			    (:from . 22)
			    (:subject)))
(defun skeleten/mu4e/unbold-fonts ()
  (interactive)
  (set-face-attribute 'mu4e-header-highlight-face nil
		      :bold nil)
  (set-face-attribute 'mu4e-unread-face nil
		      :bold nil)
  (set-face-attribute 'mu4e-flagged-face nil
		      :bold nil)
  (set-face-attribute 'mu4e-context-face nil
		      :bold nil))
(add-hook 'mu4e-headers-mode-hook
	  'skeleten/mu4e/unbold-fonts)

(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(setq rcirc-server-alist
      '(("irc.freenode.net" :port 6697 :encryption tls
	 :channels ("#archlinux-newbie"))
	("irc.mozilla.org" :port 6667
	 :channels ("#rust-beginners" "#rust"))
	("embyr.fyrechat.net" :port 6667
	 :channels ("#vana"))))

(setq skeleten/alert-sound
      "/usr/share/sounds/freedesktop/stereo/message-new-instant.oga")
(defun skeleten/rcirc-print-hook (process sender response target text)
  (when (and (string-match (regexp-quote (rcirc-nick process)) text)
	     (not (string= (rcirc-nick process) sender))
	     (not (string= (rcirc-server-name process) sender)))
    (start-process "beep" nil "mpv" (expand-file-name skeleten/alert-sound))))
(add-hook 'rcirc-print-functions
	  'skeleten/rcirc-print-hook)

(require 'dashboard)
(dashboard-setup-startup-hook)

(add-hook 'css-mode-hook 'rainbow-mode)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(add-to-list 'auto-mode-alist
	     '("\\.el\\'" . emacs-lisp-mode))
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(add-hook 'html-mode-hook
	  'display-line-numbers-mode)
(add-hook 'html-mode-hook
	  'zencoding-mode)
(add-hook 'html-mode-hook
	  'smartparens-mode)

(add-to-list 'load-path
	       "/usr/share/emacs/site-lisp")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(add-hook 'latex-mode-hook 'display-line-numbers-mode)
(add-hook 'latex-mode-hook 'company-mode)
(add-hook 'latex-mode-hook 'smartparens-mode)
(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)
(add-hook 'LaTeX-mode-hook 'company-mode)
(add-hook 'LaTeX-mode-hook 'smartparens-mode)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
; (setq TeX-PDF-mode t)

(add-hook 'markdown-mode-hook 'display-line-numbers-mode)

(add-hook 'org-mode-hook
	  'smartparens-mode)
(add-hook 'org-mode-hook
	  'display-line-numbers-mode)

(defun skeleten/org/get-org-files ()
  (mapcar (lambda (f)
	    (concat
	     (file-name-as-directory skeleten/org-files-base-dir) f))
	  (directory-files skeleten/org-files-base-dir nil "\\.org$")))

(setq org-default-notes-file "~/org/Main.org"
      org-agenda-files (skeleten/org/get-org-files)
      org-log-done 'time)
(setq org-src-fontify-natively t
      org-return-follows-link t)

(add-to-list 'org-latex-packages-alist
	     "\\usepackage{minted}")
;; TODO add to headers
;; \usemintedstyle{emacs}

(setq org-latex-listings 'minted)
(setq org-latex-custom-lang-environments
      '((emacs-lisp "common-lispcode")))
(setq org-latex-minted-options
      '(("breaklines" "")))
(setq org-latex-to-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode %f"
	"pdflatex -shell-escape -interaction nonstopmode %f"
	"pdflatex -shell-escape -interaction nonstopmode %f" ))

(setq skeleten/org-babel/safe-languages '("emacs-lisp"))

(org-babel-do-load-languages 'org-babel-load-languages
			     '((shell . t)))
(setq org-confirm-babel-evaluate
      (lambda (lang body) (not (member lang skeleten/org-babel/safe-languages))))

(add-hook 'prog-mode-hook 'company-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'prettify-symbols-mode)
(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(add-hook 'restclient-mode 'company-mode)

(require 'eglot)

(require 'lsp-rust)
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist
     '("\\.rs\\'" . rust-mode))

(add-hook 'rust-mode-hook #'flycheck-mode)
(add-hook 'rust-mode-hook 'origami-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook 'lsp-rust-enable)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(add-to-list 'auto-mode-alist
	     '("\\.toml\\'" . toml-mode))
(add-hook 'toml-mode-hook
	  'display-line-numbers-mode)
(add-hook 'toml-mode-hook
	  'smartparens-mode)

(add-to-list 'auto-mode-alist
	     '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
	  'display-line-numbers-mode)
(add-hook 'yaml-mode-hook
	  'smartparens-mode)

(require 'yasnippet)
(yas-global-mode)

(which-key-mode)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'multiple-cursors)

(setq neo-theme
      (if (display-graphic-p) 'icons 'arrow))

(use-package slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t)
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "Verbrennungskraftmaschinen und Fahrzeugantriebe"
   :client-id skeleten/slack/client-id
   :client-secret skeleten/slack/client-secret
   :token skeleten/slack/token
   :subscribed-channels '(allgemein it-interna)))

(ivy-mode 1)

(setq telephone-line-lhs
      '((accent . (telephone-line-vc-segment
		   telephone-line-erc-modified-channels-segment
		   telephone-line-process-segment))
	(nil	. (telephone-line-buffer-segment))))
(setq telephone-line-rhs
      '((nil	. (telephone-line-misc-info-segment))
	(accent . (telephone-line-major-mode-segment))
	(evil	. (telephone-line-airline-position-segment))))
(telephone-line-mode t)

(add-hook 'before-save-hook
	  'delete-trailing-whitespace)

(require 'promela-mode)
(require 'ob-promela)
(add-to-list 'auto-mode-alist
	     '("\\.pml\\'" . promela-mode))

(add-hook 'treemacs-mode-hook
	  'treemacs-follow-mode)
(add-hook 'treemacs-mode-hook
	  (lambda () (treemacs-git-mode 'deferred)))

;; dont use graphical icons, pretty please
(setq treemacs-no-png-images t)

;; Either `eclipse' or `intellij'
(setq skeleten/java-mode/backend	'eclipse)

(require 'company-lsp)
(if (boundp 'skeleten/java-mode/backend)
    (pcase skeleten/java-mode/backend
      ('eclipse
       (require 'lsp-java)
       (add-hook 'java-mode-hook #'lsp-java-enable))
      ('intellij
       (require 'lsp-intellij)
       (add-hook 'java-mode-hook #'lsp-intellij-enable)
       (error "XXX: IntelliJ java backend unimplemented!"))
      (other (error "Unknown java backend")))
  (error "skeleten/java/backend undbound!"))

(add-hook 'java-mode-hook 'company-mode)
(add-hook 'java-mode-hook 'flycheck-mode)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(add-hook 'lsp-ui-mode-hook
	  (lambda () (lsp-ui-doc-mode 0)))
