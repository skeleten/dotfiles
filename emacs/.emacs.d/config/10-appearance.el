;; holds configration related to the look-and-feel, sans keybindings

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; remove clutter                                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modeline                                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(column-number-mode +1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Visuals                                                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;; run this shit.
(skeleten/load-theme)
(skeleten/load-font)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (ivy-mode 1)
;;(setq ivy-use-virtual-buffers t)
(require 'helm-config)

(setq enable-recursive-minibuffers t)

(require 'window-number)
(window-number-mode)
(window-number-meta-mode)
(require 'multiple-cursors) ; not *really* a appearance thingy.
(require 'powerline)
(powerline-default-theme)

(ace-popup-menu-mode 1)
