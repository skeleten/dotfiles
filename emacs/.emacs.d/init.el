;;; init -- Initialization for my emacs config
;;; Commentary:
;;; Code:

;; Package stuff
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
(setq skeleten/font		"Source Code Pro 11"
	  skeleten/theme	'ayu)

;;
(skeleten/init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(forge ghub treepy closql emacsql-sqlite emacsql yasnippet yaml-mode window-number which-key undo-tree toml-mode telephone-line sublimity solaire-mode smartparens rustic ranger rainbow-mode rainbow-delimiters quelpa-use-package protobuf-mode paredit origami multiple-cursors mu4e-conversation mu4e-alert minimal-theme magit-popup magit lsp-ui lsp-treemacs lsp-java ivy-rich ivy-prescient ivy-posframe highlight-operators highlight-numbers highlight-indent-guides highlight-escape-sequences helm-lsp gradle-mode gdb-mi flycheck flx expand-region eglot dracula-theme doom-themes dockerfile-mode docker diminish dashboard dap-mode counsel company-prescient company-lsp centaur-tabs badwolf-theme all-the-icons adoc-mode ace-jump-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
