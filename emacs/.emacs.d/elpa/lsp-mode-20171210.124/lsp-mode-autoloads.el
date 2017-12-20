;;; lsp-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "lsp-methods" "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-methods.el"
;;;;;;  "3064e86c3ef0a81307f775f28585f8ab")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-methods.el

(let ((loads (get 'lsp-mode 'custom-loads))) (if (member '"lsp-methods" loads) nil (put 'lsp-mode 'custom-loads (cons '"lsp-methods" loads))))

(let ((loads (get 'lsp-faces 'custom-loads))) (if (member '"lsp-methods" loads) nil (put 'lsp-faces 'custom-loads (cons '"lsp-methods" loads))))

(defvar lsp-document-sync-method nil "\
How to sync the document with the language server.")

(custom-autoload 'lsp-document-sync-method "lsp-methods" t)

(defvar lsp-project-blacklist nil "\
A list of project directories for which LSP shouldn't be initialized.")

(custom-autoload 'lsp-project-blacklist "lsp-methods" t)

(defvar lsp-enable-eldoc t "\
Enable `eldoc-mode' integration.")

(custom-autoload 'lsp-enable-eldoc "lsp-methods" t)

(defvar lsp-highlight-symbol-at-point t "\
Highlight the symbol under the point.")

(custom-autoload 'lsp-highlight-symbol-at-point "lsp-methods" t)

(defvar lsp-enable-codeaction t "\
Enable code action processing.")

(custom-autoload 'lsp-enable-codeaction "lsp-methods" t)

(defvar lsp-enable-completion-at-point t "\
Enable `completion-at-point' integration.")

(custom-autoload 'lsp-enable-completion-at-point "lsp-methods" t)

(defvar lsp-enable-xref t "\
Enable xref integration.")

(custom-autoload 'lsp-enable-xref "lsp-methods" t)

(defvar lsp-enable-flycheck t "\
Enable flycheck integration.")

(custom-autoload 'lsp-enable-flycheck "lsp-methods" t)

(defvar lsp-enable-indentation t "\
Indent regions using the file formatting functionality provided by the language server.")

(custom-autoload 'lsp-enable-indentation "lsp-methods" t)

(defface lsp-face-highlight-textual '((t :background "yellow")) "\
Face used for textual occurances of symbols." :group (quote lsp-faces))

(defface lsp-face-highlight-read '((t :background "red")) "\
Face used for highlighting symbols being read." :group (quote lsp-faces))

(defface lsp-face-highlight-write '((t :background "green")) "\
Face used for highlighting symbols being written to." :group (quote lsp-faces))

;;;***

;;;### (autoloads nil "lsp-mode" "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-mode.el"
;;;;;;  "7817c14644c495c21b65caacb95bedd4")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-mode.el

(autoload 'lsp-mode "lsp-mode" "\


\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-common.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-flycheck.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-imenu.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-methods.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-mode-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-mode-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-mode.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-notifications.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-receive.el"
;;;;;;  "../../../../../.emacs.d/elpa/lsp-mode-20171210.124/lsp-send.el")
;;;;;;  (23090 60206 706439 253000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; lsp-mode-autoloads.el ends here
