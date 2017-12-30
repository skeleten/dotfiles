;; holds anything related to keybindings
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clear out unwanted collisions                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "M-m"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ivy Bindings                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(skeleten/define-global-keys
 '("C-s"	"Search"			swiper
   "C-c C-r"	"Resume previous completion"	ivy-resume
   "M-x"	"M-x"				counsel-M-x
   "C-x C-f"	"Find file"			counsel-find-file
   "C-h f"	"Describe function"		counsel-describe-function
   "C-h k"	"Describe key"			counsel-describe-key
   "C-h v"	"Describe variable"		counsel-describe-variable
   "C-x 8 RET"	"Insert Unicode char"		counsel-unicode-char))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Neotree bindings                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(skeleten/define-global-key "M-m f t" "Toggle Neotree" 'neotree-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Multiple Cursors bindings                                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-<") 'mc/mark-next-like-this)
(global-set-key (kbd "C->") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Company mode bindings                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [?\M-\t] 'company-complete)
(global-set-key [?\C-\t] 'company-complete)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-n") 'er/expand-region)
(skeleten/define-global-key "M-m c" "Compile" 'compile)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAGIT keybindings                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x g") 'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc									      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(skeleten/define-global-key "M-s" "Jump to char on screen" 'ace-jump-mode)
(global-set-key (kbd "C-a") 'smarter-move-beginning-of-line)
;; Email
(skeleten/define-global-prefix "M-m m" "Mail")
(skeleten/define-global-keys
 '("M-m m o"	"Open Email interface"		mu4e
   "M-m m u"	"Update Email and index"	mu4e-update-mail-and-index))
