;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package stuff                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq vc-follow-symlinks t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(if (require 'quelpa nil t)
    (quelpa-self-upgrade)
  (with-temp-buffer
    (url-insert-file-contents
     "https://framagit.org/steckerhalter/quelpa/raw/master/bootstrap.el")
    (eval-buffer)))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://framagit.org/steckerhalter/quelpa-use-package.git"
   :stable nil))

(require 'quelpa-use-package)
(require 'use-package-ensure)
(require 'quelpa-use-package)

(setq use-package-always-ensure t
      use-package-ensure-function 'quelpa)

(load-file "~/.emacs.d/config.el")

;; Settings

(setq skeleten/font		"Iosevka 12"
      skeleten/theme	'modus-operandi)

;;
(skeleten/init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fa30a26973f443ce67664be32a5287e7f980a24d389e97cf183f8a0ff676e41f" "ae65ccecdcc9eb29ec29172e1bfb6cadbe68108e1c0334f3ae52414097c501d2" default))
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(package-selected-packages
   '(protobuf-mode rustic ob-mermaid groovy-mode systemd modus-vivendi-theme modus-operandi-theme forge ghub treepy closql emacsql-sqlite emacsql mediawiki expand-region treemacs-magit treemacs-projectile ansible ranger doom-themes swiper transient lsp-ui lsp-treemacs lsp-mode ivy dracula-theme docker dap-mode avy quelpa diminish request company-prescient ivy-prescient prescient ivy-rich ivy-posframe posframe flx highlight-indent-guides all-the-icons centaur-tabs powerline memoize flycheck gradle-mode rainbow-mode xterm-color helm-lsp helm helm-core popup markdown-mode dash-functional cmake-mode yasnippet yaml-mode window-number which-key undo-tree treemacs toml-mode telephone-line smartparens rainbow-delimiters quelpa-use-package projectile paredit origami multiple-cursors mu4e-alert minimal-theme magit gdb-mi eglot dashboard counsel company badwolf-theme adoc-mode))
 '(safe-local-variable-values '((eval sql-highlight-postgres-keywords)))
 '(send-mail-function 'smtpmail-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
