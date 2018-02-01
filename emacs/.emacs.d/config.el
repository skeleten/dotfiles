
(defvar skeleten/font nil
  "Font to use in buffers")
(defvar skeleten/theme 'none
  "Theme to load or 'none to skip")
(defvar skeleten/org-files-base-dir ""
  "Base directory of org files")

(setq skeleten/font "Source Code Pro 12")
(setq skeleten/theme 'cyberpunk)        ; Possible  values currently are:
                                        ;  'doom - for the Doom
                                        ;  'moe-dark or 'moe-light for the moe
                                        ; themes
                                        ;  'none - for no theme
                                        ;  everything else will be interpretet as
                                        ; a theme name and trying to get loaded
                                        ; via `load-theme'
(setq skeleten/org-files-base-dir "~/org")

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

(column-number-mode +1)
(require 'powerline)
(powerline-default-theme)

(defun skeleten/load-theme ()
  "Load and set up the theme"
  (interactive)
  (if (boundp 'skeleten/theme)
      (pcase skeleten/theme
        ('doom (progn
                 (require 'doom-themes)
                 (setq doom-themes-enable-bold t
                       doom-themes-enable-italic t)
                 (load-theme 'doom-molokai t)
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
  (set-frame-font skeleten/font nil t))
;; run it
(skeleten/load-theme)
(skeleten/load-font)

(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

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
 '("C-s"        "Search"                        swiper
   "M-x"        "M-x"                           helm-M-x
   "C-x C-f"    "Find file"                     helm-find-files
   "C-h f"      "Describe function"             helm-describe-function
   "C-h k"      "Describe key"                  describe-key
   "C-x b"      "Switch buffer"                 helm-buffers-list
   ))

(skeleten/define-global-key "M-m f t" "Toggle Neotree" 'neotree-toggle)

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
 '("M-m o a"    "Open Org Agenda"       org-agenda))

(global-set-key (kbd "M-n") 'er/expand-region)
(skeleten/define-global-key "M-m c" "Compile" 'compile)
(skeleten/define-global-keys
 '("M-m s"      "Jump to char on screen"        ace-jump-char-mode
   "C-."        "Toggle folding"                origami-toggle-node))

(require 'smartparens-config)

(setq company-idle-delay 2)
(setq company-tooltip-align-annotations t)
(setq company-minimum-prefix-length 0)

(require 'org-mu4e)
(add-to-list 'load-path
             "/usr/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

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
                   (mu4e-sent-folder . "/VKM/Sent Items")
                   ))
         ))
;; Bookmarks for mu4e; They go to searches
;; b <key> to jump to them
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

(setq mu4e-headers-date-format "%Y-%m-%d"
      mu4e-use-fancy-chars t
      mu4e-view-show-images t
      mu4e-headers-fields '((:human-date . 12)
                            (:flags . 6)
                            (:from . 22)
                            (:subject)))

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq initial-buffer-choice "*dashboard*")

(add-hook 'css-mode-hook 'rainbow-mode)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(add-to-list 'auto-mode-alist        
             '("\\.el\\'" . emacs-lisp-mode))
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(add-hook 'html-mode-hook
          'linum-mode)
(add-hook 'html-mode-hook
          'zencoding-mode)
(add-hook 'html-mode-hook
          'smartparens-mode)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(add-hook 'latex-mode-hook 'linum-mode)
(add-hook 'latex-mode-hook 'company-mode)
(add-hook 'latex-mode-hook 'smartparens-mode)
(add-hook 'LaTeX-mode-hook 'linum-mode)
(add-hook 'LaTeX-mode-hook 'company-mode)
(add-hook 'LaTeX-mode-hook 'smartparens-mode)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
; (setq TeX-PDF-mode t)

(add-hook 'markdown-mode-hook 'linum-mode)

(add-hook 'org-mode-hook
          'smartparens-mode)
(add-hook 'org-mode-hook
          'linum-mode)
(add-hook 'org-mode-hook
          'org-bullets-mode)

(defun skeleten/org/get-org-files ()
  (mapcar (lambda (f)
            (concat
             (file-name-as-directory skeleten/org-files-base-dir) f))
          (directory-files skeleten/org-files-base-dir nil "\\.org$")))

(setq org-default-notes-file "~/org/Main.org"
      org-agenda-files (skeleten/org/get-org-files)
      org-log-done 'time)
(setq org-src-fontify-natively t)

(add-hook 'prog-mode-hook 'company-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'prettify-symbols-mode)
(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(add-hook 'restclient-mode 'company-mode)

(autoload 'rust-mode "rust-mode" nil t)
(require 'lsp-mode)
(require 'lsp-rust)
(require 'company-lsp)
(add-to-list 'auto-mode-alist
             '("\\.rs\\'" . rust-mode))

(setq company-lsp-async t)
(with-eval-after-load 'rust-mode
  (add-hook 'rust-mode-hook #'lsp-rust-enable)
  (add-hook 'rust-mode-hook #'flycheck-mode)
  (add-hook 'rust-mode-hook
            (lambda ()
              (setq company-backends
                    '((company-lsp
                       :with company-yasnippet)))))
  (add-hook 'rust-mode-hook 'origami-mode))

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(add-to-list 'auto-mode-alist
             '("\\.toml\\'" . toml-mode))
(add-hook 'toml-mode-hook
          'linum-mode)
(add-hook 'toml-mode-hook
          'smartparens-mode)

(add-to-list 'auto-mode-alist
             '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          'linum-mode)
(add-hook 'yaml-mode-hook
          'smartparens-mode)

(require 'yasnippet)
(yas-global-mode)

(which-key-mode)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'helm-config)
(setq enable-recursive-minibuffers t)

(require 'multiple-cursors)

(setq neo-theme
      (if (display-graphic-p) 'icons 'arrow))

(ace-popup-menu-mode 1)
