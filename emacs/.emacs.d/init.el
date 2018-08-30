;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package stuff                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package) 
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(package-initialize)

(load-file "~/.emacs.d/secrets.el")

(defun skeleten/load-init ()
  (interactive)
  (org-babel-load-file "~/.emacs.d/config.org"))

(skeleten/load-init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1B2229" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#DFDFDF"])
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   (quote
    ("a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "2af26301bded15f5f9111d3a161b6bfb3f4b93ec34ffa95e42815396da9cb560" default)))
 '(fci-rule-color "#5B6268")
 '(inhibit-startup-screen t)
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(mode-line-format nil)
 '(package-selected-packages
   (quote
    (counsel-tramp ivy ivy-bibtex ivy-dired-history ivy-pass ivy-yasnippet all-the-icons-ivy gruvbox-theme eglot dracula-theme mu4e-alert jdee fiplr "htmlize" dockerfile-mode use-package slack cargo cyberpunk-theme undo-tree yasnippet-snippets yasnippet ob-rust org-mime org-bullets zencoding-mode yaml-mode window-number which-key toml-mode swiper-helm smartparens rainbow-mode rainbow-delimiters racer powershell powerline paredit origami offlineimap neotree multiple-cursors monokai-theme moe-theme mediawiki markdown-mode magit ht flycheck-rust flatland-theme fish-mode expand-region doom-themes dashboard counsel company-restclient all-the-icons-gnus all-the-icons-dired ace-popup-menu ace-jump-mode)))
 '(send-mail-function (quote smtpmail-send-it))
 '(vc-annotate-background "#1B2229")
 '(vc-annotate-color-map
   (list
    (cons 20 "#98be65")
    (cons 40 "#ffff00")
    (cons 60 "#ffff00")
    (cons 80 "#ECBE7B")
    (cons 100 "#ffff00")
    (cons 120 "#ffff00")
    (cons 140 "#da8548")
    (cons 160 "#ffaa55")
    (cons 180 "#ff55aa")
    (cons 200 "#c678dd")
    (cons 220 "#ff00aa")
    (cons 240 "#ff0055")
    (cons 260 "#ff6c6b")
    (cons 280 "#bf003f")
    (cons 300 "#7f007f")
    (cons 320 "#3f00bf")
    (cons 340 "#5B6268")
    (cons 360 "#5B6268")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
