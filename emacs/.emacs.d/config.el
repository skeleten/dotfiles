;;; config -- Configuration methods
;;; Commentary:
;;; Code:
(defvar skeleten/font nil
  "Font to use in buffers.")
(defvar skeleten/theme 'none
  "Theme to load, or 'none to skip.")
(defvar skeleten/org-files-base-dir ""
  "Base directory of org files.")


;; Helper
(defun skeleten/helper/smarter-move-beginning-of-line (arg)
  "Move to the beginning of text in the current line."
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

(defun skeleten/helper/load-font ()
  "Load the configured fonts."
  (interactive)
  (set-face-attribute 'default nil :font skeleten/font)
  (set-frame-font skeleten/font nil t)
  (set-frame-font skeleten/font)
  (add-to-list 'default-frame-alist `(font . ,skeleten/font)))

(defun skeleten/helper/mail/set-account ()
  "Setup mail accounts for mu4e."
  (let* ((account
		  (if mu4e-compose-parent-message
			  (let ((maildir (mu4e-message-field mu4e-compose-parent-message
												 :maildir)))
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
  "Alter faces used in mu4e to not be bold."
  (interactive)
  (set-face-attribute 'mu4e-header-highlight-face nil :bold nil)
  (set-face-attribute 'mu4e-unread-face nil :bold nil)
  (set-face-attribute 'mu4e-flagged-face nil :bold nil)
  (set-face-attribute 'mu4e-context-face nil :bold nil))

(defun skeleten/helper/def-global-key (key desc command)
  "Define a global keybinding KEY with the description DESC to execute COMMAND."
  (global-set-key (kbd key) command)
  (which-key-add-key-based-replacements key desc))

(defun skeleten/helper/def-global-prefix (pref desc)
  "Define a global prefix PREF with the description DESC."
  (which-key-add-prefix-title pref desc))

(defun skeleten/helper/draw-pgbrk-as-line ()
  "Draw pagebreaks as a solid Line.
Credit: http://ergoemacs.org/emacs/emacs_form_feed_section_paging.html ."
  (interactive)
  (progn (when (not buffer-display-table)
	   (setq buffer-display-table (make-display-table)))
	 (aset buffer-display-table ?\^L
	       (vconcat (make-list 80 (make-glyph-code ?─ 'font-lock-comment-face))))
	 (redraw-frame)))

(defun skeleten/helper/edit-above ()
  "Insert a new line above the current and move the cursor there."
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line)
  (indent-for-tab-command))


;; INIT
(defun skeleten/init/packages ()
  "Initialize packages.
This will download/install any missing packages and take care of the
configuration using `use-package'."
  (use-package emacs
    :preface
    (defvar skeleten/indent-width 4)
    :config
    (setq frame-title-format '("emacs")
		  ring-bell-function 'ignore
		  frame-resize-pixelwise t
		  default-directory "~/")
	;; scrolling
    (setq scroll-margin 0
		  scroll-conservatively 10000
		  scroll-preserve-screen-position t
		  auto-window-vscroll nil
		  mouse-wheel-scroll-amount '(1 ((shift) . 1))
		  mouse-wheel-progressive-speed nil)
    (setq line-spacing 3)
    (setq-default indent-tabs-mode t
				  tab-width skeleten/indent-width)
	;; less clutter
	(tool-bar-mode -1)
    (menu-bar-mode -1)
	(scroll-bar-mode -1)
	;; other tweaks
	(delete-selection-mode +1)
	(column-number-mode +1)
	;; offsets
	(setq-default c-basic-offset skeleten/indent-width))

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

    ;; accounts
    (setq mu4e-contexts
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
    (setq mu4e-bookmarks
	  `( ,(make-mu4e-bookmark
	       :name "VKM"
	       :query "maildir:\"/VKM/Inbox*\" AND NOT flag:tashed"
	       :key ?v)
	     ,(make-mu4e-bookmark
	       :name "Privat"
	       :query "maildir:\"/skeleten/Inbox*\" AND NOT flag:trashed"
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
				(:subject))
	  mu4e-get-mail-command "mbsync -a")

    :hook ((mu4e-compose-pre . skeleten/helper/mail/set-account)
	   (mu4e-headers-mode . skeleten/helper/mail/unbold-fonts)))

  (use-package mu4e-alert
    :requires mu4e
    :config (setq mu4e-alert-set-default-style 'libnotify)
    :hook ((after-init . mu4e-alert-enable-notifications)))

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
    :ensure t
    :config
    (dashboard-setup-startup-hook)
    (setq dashboard-items '((recents . 10)
			    (bookmarks . 5))))
  ;; modes, mostly

  (use-package css-mode
    :hook ((css-mode . rainbow-mode)))

  (use-package paredit
    :ensure t
    :hook ((emacs-lisp-mode . enable-paredit-mode)))

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

  (use-package rainbow-delimiters)

  (use-package prog-mode
	:config
	(setq-default fill-column 100)
    :hook
    ((prog-mode . company-mode)
     (prog-mode . display-line-numbers-mode)
	 (prog-mode . display-fill-column-indicator-mode)
     (prog-mode . prettify-symbols-mode)
     (prog-mode . smartparens-mode)
     (prog-mode . rainbow-delimiters-mode)
	 (prog-mode . hs-minor-mode)))

  (use-package flycheck :config (global-flycheck-mode +1))
  (use-package restclient-mode
    :hook
    ((restcleint-mode . company-mode)))
  (use-package rustic
    :mode ("\\.rs\\'" . rustic-mode)
    :requires ra-emacs-lsp lsp-mode dash ht
    :config
	(setq fill-column 100)
    (lsp-register-client
     (make-lsp-client
      :new-connection (lsp-stdio-connection (lambda () rust-analyzer-command))
      :notification-handlers (ht<-alist rust-analyzer--notification-handlers)
      :action-handlers (ht<-alist rust-analyzer--action-handlers)
      :major-modes '(rustic-mode rust-mode)
      :priority 1
      :ignore-messages nil
      :server-id 'rust-analyzer))
	(defun /skeleten/rustic-mode/setup ()
	  (setq fill-column 100))
    :hook
    ((rustic-mode . lsp)
     (rustic-mode . flycheck-mode)
     (rustic-mode . origami-mode)
     (rustic-mode . cargo-minor-mode)
     (rustic-mode . yas-minor-mode-on)
	 (rustic-mode . /skeleten/rustic-mode/setup)
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
    :config
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
		  treemacs-no-png-images nil)
    :hook
    ((treemacs-mode . treemacs-follow-mode)))

  (use-package lsp-mode)
  (use-package lsp-ui
    :requires lsp-mode
    :hook ((lsp-mode . lsp-ui-mode))
    :config
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-sideline-enable nil))
  (use-package company-lsp
    :requires lsp-mode)
  (use-package lsp-treemacs
    :requires lsp-mode)
  (use-package helm-lsp
    :requires lsp-mode)
  (use-package dap-mode
    :requires lsp-mode)

  (use-package ra-emacs-lsp
    :load-path "/home/skeleten/.emacs.d/cust"
    :requires lsp-mode)

  (use-package ivy
    :config
    (ivy-mode 1))
  (use-package swiper
    :requires ivy
	:config
	(setq swiper-action-recenter t
		  swiper-goto-start-of-match t)
    :bind (("C-s"	. swiper)))
  (use-package counsel
    :requires swiper ivy
	:hook (ivy-mode . counsel-mode)
    :bind (("M-x"	. counsel-M-x)
	   ("C-x C-f"	. counsel-find-file)
	   ("C-h f"	. counsel-describe-function)))
  (use-package ivy-posframe
	:after ivy
	:diminish
	:config
	(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))
		  ivy-posframe-height-alist '((t . 20))
		  ivy-posframe-parameters '((internal-border-width . 10))
		  ivy-posframe-width 70)
	(ivy-posframe-mode +1))

  (use-package ivy-rich
	:preface
	(defun ivy-rich-switch-buffer-icon (candidate)
	  (with-current-buffer
		  (get-buffer candidate)
		(all-the-icons-icon-for-buffer)))
	(defun ivy-rich-switch-buffer-get-buffer (cand)
	  (get-buffer cand))
	:init
	(setq ivy-rich-display-transformers-list ; max column width sum = (ivy-poframe-width - 1)
		  '(ivy-switch-buffer
			(:columns
			 ((ivy-rich-switch-buffer-icon (:width 2))
			  (ivy-rich-candidate (:width 35))
			  (ivy-rich-switch-buffer-project (:width 15 :face success))
			  (ivy-rich-switch-buffer-major-mode (:width 13 :face warning))
			  )
			 :predicate ivy-rich-switch-buffer-get-buffer
			 )
			counsel-M-x
			(:columns
			 ((counsel-M-x-transformer (:width 35))
			  (ivy-rich-counsel-function-docstring (:width 34 :face font-lock-doc-face))))
			counsel-describe-function
			(:columns
			 ((counsel-describe-function-transformer (:width 35))
			  (ivy-rich-counsel-function-docstring (:width 34 :face font-lock-doc-face))))
			counsel-describe-variable
			(:columns
			 ((counsel-describe-variable-transformer (:width 35))
			  (ivy-rich-counsel-variable-docstring (:width 34 :face font-lock-doc-face))))
			package-install
			(:columns
			 ((ivy-rich-candidate (:width 25))
			  (ivy-rich-package-version (:width 12 :face font-lock-comment-face))
			  (ivy-rich-package-archive-summary (:width 7 :face font-lock-builtin-face))
			  (ivy-rich-package-install-summary (:width 23 :face font-lock-doc-face))))))
	:config
	(ivy-rich-mode +1)
	(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

  (use-package magit
    :bind (("C-x g" . magit-status)))
  (use-package forge
	:after magit
	:config
	(add-to-list 'forge-alist
				 '("git.vkm.maschinenbau.tu-darmstadt.de"
				   "git.vkm.maschinenbau.tu-darmstadt.de/api/v4"
				   "git.vkm.maschinenbau.tu-darmstadt.de"
				   forge-gitlab-repository)))

  (use-package avy
    :bind (("M-m s" . avy-goto-char)
	   ("M-m S" . avy-goto-char-2)
	   ("M-m w" . avy-copy-region)
	   ("M-m k" . avy-kill-line)
	   ("M-m K" . avy-kill-region)))

  (use-package hs-minor-mode
	:bind (("C-." . hs-toggle-hiding)))

  (use-package projectile
	:config (setq projectile-completion-system 'ivy)
    :bind (("M-m f f" . projectile-find-file)))

  (use-package treemacs
    :bind (("M-m f t" . treemacs)))

  (use-package org
    :bind
    (("M-m o a" . org-agenda))
    :config
    (setq org-agenda-files '("~/org")))

  (use-package protobuf-mode
    :hook ((protobuf-mode . smartparens-mode)
	   (protobuf-mode . display-line-number-mode)))
  (use-package ace-jump-mode)
  (use-package docker)
  (use-package dockerfile-mode)
  (use-package avy
    :bind (("M-m s" . avy-goto-char)
	   ("M-m S" . avy-goto-char-2)
	   ("M-m w" . avy-copy-line)
	   ("M-m W" . avy-copy-region)
	   ("M-m k" . avy-kill-region)))

  (use-package gradle-mode)

  (use-package ediff
	:ensure nil
	:config
	(setq ediff-split-window-function 'split-window-horizontally))

  (use-package highlight-numbers
	:hook (prog-mode . highlight-numbers-mode))
  (use-package highlight-operators
	:hook ((c-mode . highlight-operators-mode)
		   (rust-mode . highlight-operators-mode)))
  (use-package highlight-escape-sequences
	:hook (prog-mode . hes-mode))
  (use-package solaire-mode
	:hook
	((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
	(minibuffer-setup . solaire-mode-in-minibuffer)
	:config
	(solaire-global-mode +1)
	(solaire-mode-swap-bg))
  (use-package all-the-icons)
  (use-package centaur-tabs
	:demand
	:init
	(setq centaur-tabs-set-bar 'over)
	:config
	(centaur-tabs-mode +1)
	(centaur-tabs-headline-match)
	(centaur-tabs-group-by-projectile-project)
	(setq centaur-tabs-style "bar"
		  centaur-tabs-set-icons t
		  centaur-tabs-set-modified-marker t
		  centaur-tabs-cycle-scope 'tabs
		  centaur-tabs-modified-marker " ● "
		  centaur-tabs-close-button " × "
		  centaur-tabs-height 34)
	:bind
	("C-<tab>" . centaur-tabs-forward)
	("C-<prior>" . centaur-tabs-backward)
	("C-S-<prior>" . centaur-tabs-backward-group)
	("C-<next>" . centaur-tabs-forward)
	("C-S-<next>" . centaur-tabs-forward-group)
	("C-S-<return>" . centaur-tabs-switch-group))

  (use-package highlight-indent-guides
	:config (setq highlight-indent-guides-method 'character)
	:hook (prog-mode . highlight-indent-guides-mode))

  (use-package flx)
  (use-package prescient
	:config
	(setq precient-filter-method '(literal regexp initialism fuzzy))
	(prescient-persist-mode +1))
  (use-package ivy-prescient
	:after (prescient ivy)
	:config
	(setq ivy-prescient-sort-commands '(:not swiper counsel-grp ivy-switch-buffer))
	(setq ivy-prescient-retain-classic-highlighting t)
	(ivy-prescient-mode +1))
  (use-package company-prescient
	:after (prescient company)
	:config (company-prescient-mode +1))
  (use-package diminish)
  (use-package doom-themes
	:config
	(setq doom-themes-enable-bold t
		  doom-themes-enable-italic t)
	(load-theme 'doom-vibrant t)
	(doom-themes-visual-bell-config)
	(doom-themes-neotree-config)
	(setq doom-themes-treemacs-theme "doom-colors")
	(doom-themes-treemacs-config)
	(doom-themes-org-config))
  (use-package ranger
	:config
	(setq ranger-cleanup-eagerly t))
  (use-package sublimity)
  (use-package sublimity-scroll
	:requires sublimity)
  (use-package expand-region
	:bind
	(("M-n" . 'er/expand-region)))
  ;; END OF USE-PACKAGE
)

(defun skeleten/init/misc ()
  "Misc stuff, that hasnt been sorted yet."
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
			   (skeleten/helper/load-font))))
    (skeleten/helper/load-font))

  ;; Kill background processes
  (setq confirm-kill-processes nil)
  ;; no backup files
  (setq make-backup-files nil)
  ;; misc hooks
  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; (global-set-key (kbd "M-n") 'er/expand-region)
  ;; (skeleten/helper/def-global-key "M-m c" "compile" 'compile)
  (global-set-key (kbd "M-p") 'skeleten/helper/edit-above))

(defun skeleten/init ()
  "Custom initializiation routines."
  (interactive)
  (progn
	(skeleten/init/misc)
	(skeleten/init/packages)))
;;; config.el ends here
