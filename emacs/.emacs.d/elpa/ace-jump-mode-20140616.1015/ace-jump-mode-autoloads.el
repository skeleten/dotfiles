;;; ace-jump-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "ace-jump-mode" "../../../../../.emacs.d/elpa/ace-jump-mode-20140616.1015/ace-jump-mode.el"
;;;;;;  "d5e3d4a5fa37957b045c9f78293d5b7e")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/ace-jump-mode-20140616.1015/ace-jump-mode.el

(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "\
Pop up a postion from `ace-jump-mode-mark-ring', and jump back to that position" t nil)

(autoload 'ace-jump-char-mode "ace-jump-mode" "\
AceJump char mode

\(fn QUERY-CHAR)" t nil)

(autoload 'ace-jump-word-mode "ace-jump-mode" "\
AceJump word mode.
You can set `ace-jump-word-mode-use-query-char' to nil to prevent
asking for a head char, that will mark all the word in current
buffer.

\(fn HEAD-CHAR)" t nil)

(autoload 'ace-jump-line-mode "ace-jump-mode" "\
AceJump line mode.
Marked each no empty line and move there" t nil)

(autoload 'ace-jump-mode "ace-jump-mode" "\
AceJump mode is a minor mode for you to quick jump to a
position in the curret view.
   There is three submode now:
     `ace-jump-char-mode'
     `ace-jump-word-mode'
     `ace-jump-line-mode'

You can specify the sequence about which mode should enter
by customize `ace-jump-mode-submode-list'.

If you do not want to query char for word mode, you can change
`ace-jump-word-mode-use-query-char' to nil.

If you don't like the default move keys, you can change it by
setting `ace-jump-mode-move-keys'.

You can constrol whether use the case sensitive via
`ace-jump-mode-case-fold'.

\(fn &optional PREFIX)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "ace-jump-mode"
;;;;;;  "../../../../../.emacs.d/elpa/ace-jump-mode-20140616.1015/ace-jump-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/ace-jump-mode-20140616.1015/ace-jump-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ace-jump-mode" '("ace-jump-" "aj-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/ace-jump-mode-20140616.1015/ace-jump-mode-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/ace-jump-mode-20140616.1015/ace-jump-mode.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ace-jump-mode-autoloads.el ends here
