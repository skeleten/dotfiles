;;; highlight-operators-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "highlight-operators" "../../../../../.emacs.d/elpa/highlight-operators-20170213.2320/highlight-operators.el"
;;;;;;  "b77487bc4676994b572dbcded8ee9148")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/highlight-operators-20170213.2320/highlight-operators.el

(autoload 'highlight-operators-mode "highlight-operators" "\
Extra highlighting for operators in programming modes.

If called interactively, enable Highlight-Operators mode if ARG
is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(put 'global-highlight-operators-mode 'globalized-minor-mode t)

(defvar global-highlight-operators-mode nil "\
Non-nil if Global Highlight-Operators mode is enabled.
See the `global-highlight-operators-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-highlight-operators-mode'.")

(custom-autoload 'global-highlight-operators-mode "highlight-operators" nil)

(autoload 'global-highlight-operators-mode "highlight-operators" "\
Toggle Highlight-Operators mode in all buffers.
With prefix ARG, enable Global Highlight-Operators mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Highlight-Operators mode is enabled in all buffers where
`(lambda nil (highlight-operators-mode 1))' would do it.
See `highlight-operators-mode' for more information on Highlight-Operators mode.

\(fn &optional ARG)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "highlight-operators"
;;;;;;  "../../../../../.emacs.d/elpa/highlight-operators-20170213.2320/highlight-operators.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/highlight-operators-20170213.2320/highlight-operators.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "highlight-operators" '("highlight-operators-regexp")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/highlight-operators-20170213.2320/highlight-operators-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/highlight-operators-20170213.2320/highlight-operators.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; highlight-operators-autoloads.el ends here
