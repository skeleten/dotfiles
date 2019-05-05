;; Variablen

(defvar skeleten/font nil
  "Font to use in buffers")
(defvar skeleten/theme 'none
  "Theme to load, or 'none to skip")
(defvar skeleten/org-files-base-dir ""
  "Base directory of org files")

;; Helper
(defun skeleten/helper/smarter-move-beginning-of-line (arg)
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

(defun skeleten/helper/load-theme ()
  (interactive)
  (if (boundp 'skeleten/theme)
      (pcase skeleten/theme
	;; some special treatments
	('doom (progn (require 'doom-themes)
		      (setq doom-themes-enable-bold t
			    doom-themes-enable-italic t)
		      (load-theme 'doom-one t)
		      (doom-themes-visual-bell-config)
		      (doom-themes-neotree-config)))
	('doom-safe (progn (require 'doom-themes)
			   (setq doom-themes-enable-bold t
				 doom-themes-enable-italic t)
			   (load-theme 'doom-molokai t)
			   (doom-themes-visual-bell-config)))
	('moe-dark (progn (require 'moe-theme)
			  (setq custom-safe-themes 't)
			  (load-theme 'moe-dark)))
	('moe-light (progn (require 'moe-theme)
			   (setq custom-safe-themes 't)
			   (load-theme 'moe-light)))
	('none nil)
	(other (progn (setq custom-safe-themes 't)
		      (load-theme other))))))

(defun skeleten/helper/load-font ()
  (interactive)
  (set-face-attribute 'default nil :font skeleten/font)
  (set-frame-font skeleten/font nil t)
  (set-default-font skeleten/font)
  (add-to-list 'default-frame-alist `(font . ,skeleten/font)))

(defun skeleten/helper/mail/set-account ()
  (let* ((account
	  (if mu4e-compose-parent-message
	      (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
		(string-match "/\\(.*?\\)/" maildir))
	    (mu4e-context-name (mu4e-context-current))))
	 (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
	(mapc #'(lambda (var)
		  (message "set " (car var) " to " (cadr var))
		  (set (car var) (cadr var)))
	      account-vars)
      (error "No email account found"))))

(defun skeleten/helper/mail/unbold-fonts ()
  (interactive)
  (set-face-attribute 'mu4e-header-highlight-face nil :bold nil)
  (set-face-attribute 'mu4e-unread-face nil :bold nil)
  (set-face-attribute 'mu4e-flagged-face nil :bold nil)
  (set-face-attribute 'mu4e-context-face nil :bold nil))

(defun skeleten/helper/def-global-key (key desc command)
  (global-set-key (kbd key) command)
  (which-key-add-key-based-replacements key desc))

(defun skeleten/helper/def-global-prefix (pref desc)
  (which-key-add-prefix-title pref desc))

(defun skeleten/helper/draw-pgbrk-as-line ()
  "Credit: http://ergoemacs.org/emacs/emacs_form_feed_section_paging.html"
  (interactive)
  (progn (when (not buffer-display-table)
	   (setq buffer-display-table (make-display-table)))
	 (aset buffer-display-table ?\^L
	       (vconcat (make-list 80 (make-glyph-code ?─ 'font-lock-comment-face))))
	 (redraw-frame)))

(defun skeleten/helper/edit-above ()
  (interactive)
  (previous-line)
  (end-of-line)
  (newline)
  (indent-for-tab-command))


;; INIT
(defun skeleten/init ()
  (interactive)

  ;; Keybindings
  (global-set-key [remap move-beginning-of-line]
		  'skeleten/helper/smarter-move-beginning-of-line)
  (global-unset-key (kbd "M-m"))
  ;; finding and searching
  ;; TODO: move these into `use-packages`'s ASAP
  (global-set-key [?\M-\t] 'company-complete)
  (global-set-key [?\C-\t] 'company-complete)
  (global-set-key (kbd "C-S-i") 'imenu)

  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

  ;; load theme and font on appriopiate time
  (if (daemonp)
      (add-hook 'after-make-frame-functions
		(lambda (frm) (with-selected-frame frm
			   (skeleten/helper/load-theme)
			   (skeleten/helper/load-font))))
    (skeleten/helper/load-theme)
    (skeleten/helper/load-font))

  ;; less clutter
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)

  ;; modes
  (use-package window-number
    :config
    (window-number-mode)
    (window-number-meta-mode))
  (use-package smartparens
    :config
    (require 'smartparens-config))
  (use-package mu4e
    :init
    (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
    :bind (("M-m m o" . mu4e)
	   ("M-m m u" . mu4e-update-mail-and-index))
    :config
    (when (fboundp 'imagemagick-register-types)
      (imagemagick-register-types))
    (setq mu4e-update-interval 60)
    (mu4e-alert-set-default-style 'libnotify)
    (mu4e-alert-enable-mode-line-display)

    ;; accounts
    (setq mu4e-context
	  `( ,(make-mu4e-context
	       :name "skeleten"
	       :match-func
	       (lambda (msg)
		 (when msg (string-prefix-p "/skeleten" (mu4e-message-field msg :maildir))))
	       :vars '((mu4e-trash-folder . "/skeleten/Trash")
		       (mu4e-refile-folder . "/skeleten/Archive")
		       (mu4e-sent-folder . "/skeleten/Sent")))
	     ,(make-mu4e-context
	       :name "VKM"
	       :match-func
	       (lambda (msg)
		 (when msg (string-prefix-p "/VKM" (mu4e-message-field msg :maildir))))
	       :vars '((mu4e-trash-folder . "/VKM/Deleted Items")
		       (mu4e-refile-folder . "/VKM/Archive")
		       (mu4e-sent-folder . "/VKM/Sent Items")))))
    (setq my-mu4e-account-alist
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
	     (smtpmail-smtp-service 587))))

    ;; bookmarks
    (setq mu4e-bookmark
	  `( ,(make-mu4e-bookmark
	       :name "VKM"
	       :query "maildir:\"/VKM/INBOX\" AND NOT flag:tashed"
	       :key ?v)
	     ,(make-mu4e-bookmark
	       :name "Privat"
	       :query "maildir:\"skeleten/INBOX*\" AND NOT flag:trashed"
	       :key ?p)
	     ,(make-mu4e-bookmark
	       :name "Unread messages"
	       :query "flag:unread AND NOT flag:trashed"
	       :key ?u)))

    ;; Customization
    (setq mu4e-headers-date-format "%Y-%m-%d"
	  mu4e-use-fancy-chars nil
	  mu4e-view-show-images t
	  mu4e-headers-fields '((:human-date . 12)
				(:flags . 6)
				(:from . 22)
				(:subject)))

    :hook ((after-init . mu4e-alert-enable-notifications)
	   (mu4e-compose-pre . skeleten/helper/mail/set-account)
	   (mu4e-headers-mode . skeleten/helper/mail/unbold-fonts)))



  (use-package company
    :config
    (setq company-idle-delay 2)
    (setq company-tooltip-align-annotations t)
    (setq company-minimum-prefix-length 1))

  (use-package rcirc
    :config
    (setq rcirc-server-alist
	  '(("irc.freenode.net" :port 6667 :encryption tls
	     :channels ("#archlinux-newbie"))
	    ("irc.mozilla.org" :port 6667 :encryption tls
	     :channels ("#rust-beginners" "#rust"))
	    ("embyr.fyrechat.net" :port 6667
	     :channels ("#vana")))))

  (use-package dashboard
    :config
    (dashboard-setup-startup-hook))

  ;; modes, mostly

  (use-package css-mode
    :hook ((css-mode . rainbow-mode)))

  (use-package paredit
    :ensure t
    :hook ((emacs-lisp-mode . paredit-mode)))

  (use-package latex
    :init
    (add-to-list 'load-path "/usr/share/emacs/site-lisp")
    (load "auctex.el" nil t t)
    (load "preview-latex.el" nil t t)

    :config
    (setq TeX-auto-save t
	  TeX-parse-self t
	  TeX-save-query nil)

    :hook
    ((latex-mode . display-line-numbers-mode)
     (latex-mode . company-mode)
     (latex-mode . smartparens-mode))

    :requires smartparens)

  (use-package prog-mode
    :hook
    ((prog-mode . company-mode)
     (prog-mode . display-line-numbers-mode)
     (prog-mode . prettify-symbols-mode)
     (prog-mode . smartparens-mode)
     (prog-mode . rainbow-delimiters-mode)))
  (use-package restclient-mode
    :hook
    ((restcleint-mode . company-mode)))
  (use-package rust-mode
    :mode "\\.rs\\'"
    :init
    (autoload 'rust-mode "rust-mode" nil t)

    :hook
    ((rust-mode . flycheck-mode)
     (rust-mode . origami-mode)
     (rust-mode . cargo-minor-mode)
     (rust-mode . yas-minor-mode-on)
     (flycheck-mode . flycheck-rust-setup)))
  (use-package toml-mode
    :mode "\\.toml\\'"
    :hook
    ((toml-mode . display-line-numbers-mode)
     (toml-mode . smartparens-mode)))

  (use-package yaml-mode
    :mode "\\.yml\\'"
    :hook
    ((yaml-mode . display-line-numbers-mode)
     (yaml-mode . smartparens-mode)))
  (use-package yasnippet
    :init
    (yas-global-mode))
  (use-package which-key
    :init
    (which-key-mode))
  (use-package undo-tree
    :init
    (global-undo-tree-mode))
  (use-package multiple-cursors
    :bind (("C-S-c C-S-c" . mc/edit-lines)
	   ("C-<" . mc/mark-next-like-this)
	   ("C->" . mc/mark-previous-like-this)
	   ("C-c C-<" . mc/mark-all-like-this)))

  (use-package telephone-line
    :init
    (setq telephone-line-lhs
	  '((accent . (telephone-line-vc-segment
		       telephone-line-process-segment))
	    (nil . (telephone-line-buffer-segment))))
    (setq telephone-line-rhs
	  '((nil . (telephone-line-misc-info-segment))
	    (accent . (telephone-line-major-mode-segment))
	    (evil . (telephone-line-airline-position-segment))))
    :config
    (telephone-line-mode 1))
  (use-package treemacs
    :config
    (add-hook 'treemacs-mode-hook
	      (lambda () (treemacs-git-mode 'deferred)))
    (setq treemacs-width 25
	  treemacs-show-hidden-files t
	  treemacs-no-png-images t)
    :hook
    ((treemacs-mode . treemacs-follow-mode)))

  (use-package eglot
    :requires rust-mode)

  (use-package adoc-mode
    :mode "\\.adoc\\'")

  (use-package swiper
    :bind (("C-s" . swiper)
	   ("M-x" . counsel-M-x)
	   ("C-x C-f" . counsel-find-file)
	   ("C-h f" . counsel-describe-function)))
  (use-package magit
    :bind (("C-x g" . magit-status)))

  (use-package ace-jump-char
    :bind (("M-m s" . ace-jump-char-mode)))

  (use-package origami
    :bind (("C-." . origami-toggle-node)))

  (use-package projectile
    :bind (("M-m f f" . projectile-find-file)))

  (use-package treemacs
    :bind (("M-m f t" . treemacs)))

  ;; misc hooks
  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; (global-set-key (kbd "M-n") 'er/expand-region)
  ;; (skeleten/helper/def-global-key "M-m c" "compile" 'compile)
  (global-set-key (kbd "M-p") 'skeleten/helper/edit-above)
)
