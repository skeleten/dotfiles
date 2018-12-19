;;; mtg-deck-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "mtg-deck-mode" "mtg-deck-mode.el" (0 0 0 0))
;;; Generated autoloads from mtg-deck-mode.el

(autoload 'mtg-deck-sideboard-toggle "mtg-deck-mode" "\
Toggle the current card or region as a sideboard card.

\(fn)" t nil)

(autoload 'mtg-deck-show-card-at-point "mtg-deck-mode" "\
Show card at point in a new buffer.

\(fn)" t nil)

(autoload 'mtg-deck-show-card "mtg-deck-mode" "\
Choose and show a card in a new buffer.

\(fn)" t nil)

(autoload 'mtg-deck-mode "mtg-deck-mode" "\
Major mode to edit MTG decks.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.(mw)?dec\\'" . mtg-deck-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mtg-deck-mode" '("mtg-deck-")))

;;;***

;;;### (autoloads nil nil ("mtg-deck-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; mtg-deck-mode-autoloads.el ends here
