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

(package-initialize)

(if (require 'quelpa nil t)
    ; (quelpa-self-upgrade)
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

(setq skeleten/font		"Source Code Pro 12"
      skeleten/theme		'badwolf)

;;
(skeleten/init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rustic xterm-color helm-lsp helm helm-core popup markdown-mode dash-functional cmake-mode yasnippet yaml-mode window-number which-key undo-tree treemacs toml-mode telephone-line smartparens rust-mode rainbow-delimiters quelpa-use-package protobuf-mode projectile paredit origami multiple-cursors mu4e-alert minimal-theme magit gdb-mi eglot dashboard counsel company badwolf-theme adoc-mode)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
