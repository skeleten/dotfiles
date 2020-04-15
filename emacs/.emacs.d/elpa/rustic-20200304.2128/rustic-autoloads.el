;;; rustic-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rustic" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic.el"
;;;;;;  "4318f170012c48f7876654162840e09d")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic.el

(autoload 'rustic-mode "rustic" "\
Major mode for Rust code.

\\{rustic-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))

;;;### (autoloads "actual autoloads are elsewhere" "rustic" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic" '("rust")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "rustic-babel"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-babel.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-babel.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-babel" '("org-babel-execute:rustic" "rustic-")))

;;;***

;;;### (autoloads nil "rustic-cargo" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-cargo.el"
;;;;;;  "0b761d7411938f401d51768056483268")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-cargo.el

(autoload 'rustic-cargo-clippy "rustic-cargo" "\
Run `cargo clippy'." t nil)

(autoload 'rustic-cargo-test-run "rustic-cargo" "\
Start compilation process for 'cargo test' with optional TEST-ARGS.

\(fn &optional TEST-ARGS)" t nil)

(autoload 'rustic-cargo-test "rustic-cargo" "\
Run 'cargo test'.

If ARG is not nil, use value as argument and store it in `rustic-test-arguments'.
When calling this function from `rustic-popup-mode', always use the value of
`rustic-test-arguments'.

\(fn &optional ARG)" t nil)

(autoload 'rustic-cargo-test-rerun "rustic-cargo" "\
Run 'cargo test' with `rustic-test-arguments'." t nil)

(autoload 'rustic-cargo-current-test "rustic-cargo" "\
Run 'cargo test' for the test near point." t nil)

(autoload 'rustic-cargo-outdated "rustic-cargo" "\
Use 'cargo outdated' to list outdated packages in `tabulated-list-mode'.
Execute process in PATH.

\(fn &optional PATH)" t nil)

(autoload 'rustic-cargo-reload-outdated "rustic-cargo" "\
Update list of outdated packages." t nil)

(autoload 'rustic-cargo-mark-upgrade "rustic-cargo" "\
Mark an upgradable package." t nil)

(autoload 'rustic-cargo-mark-all-upgrades "rustic-cargo" "\
Mark all upgradable packages in the Package Menu." t nil)

(autoload 'rustic-cargo-menu-mark-unmark "rustic-cargo" "\
Clear any marks on a package." t nil)

(autoload 'rustic-cargo-upgrade-execute "rustic-cargo" "\
Perform marked menu actions." t nil)

(autoload 'rustic-cargo-new "rustic-cargo" "\
Run 'cargo new' to start a new package in the path specified by PROJECT-PATH.
If BIN is not nil, create a binary application, otherwise a library.

\(fn PROJECT-PATH &optional BIN)" t nil)

(autoload 'rustic-cargo-build "rustic-cargo" "\
Run 'cargo build' for the current project." t nil)

(autoload 'rustic-cargo-run "rustic-cargo" "\
Run 'cargo run' for the current project." t nil)

(autoload 'rustic-cargo-clean "rustic-cargo" "\
Run 'cargo clean' for the current project." t nil)

(autoload 'rustic-cargo-check "rustic-cargo" "\
Run 'cargo check' for the current project." t nil)

(autoload 'rustic-cargo-bench "rustic-cargo" "\
Run 'cargo bench' for the current project." t nil)

(autoload 'rustic-cargo-build-doc "rustic-cargo" "\
Build the documentation for the current project." t nil)

(autoload 'rustic-cargo-doc "rustic-cargo" "\
Open the documentation for the current project in a browser.
The documentation is built if necessary." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "rustic-cargo"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-cargo.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-cargo.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-cargo" '("rustic-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "rustic-common"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-common.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-common.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-common" '("rustic-")))

;;;***

;;;### (autoloads nil "rustic-compile" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-compile.el"
;;;;;;  "053e1e4494334e0be074609c1049cd94")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-compile.el

(autoload 'rustic-compile "rustic-compile" "\
Compile rust project.
If called without arguments use `rustic-compile-command'.

Otherwise use provided argument ARG and store it in
`compilation-arguments'.

\(fn &optional ARG)" t nil)

(autoload 'rustic-recompile "rustic-compile" "\
Re-compile the program using `compilation-arguments'." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "rustic-compile"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-compile.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-compile.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-compile" '("rust")))

;;;***

;;;***

;;;### (autoloads nil "rustic-flycheck" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-flycheck.el"
;;;;;;  "aa304887a16448c15d78cc8084cff300")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-flycheck.el

(autoload 'rustic-flycheck-setup "rustic-flycheck" "\
Setup Rust in Flycheck.

If the current file is part of a Cargo project, configure
Flycheck according to the Cargo project layout." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "rustic-flycheck"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-flycheck.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-flycheck.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-flycheck" '("rustic-flycheck-")))

;;;***

;;;***

;;;### (autoloads nil "rustic-interaction" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-interaction.el"
;;;;;;  "d02267098acc6dda3a2ff8a5a8809300")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-interaction.el

(autoload 'rustic-indent-line "rustic-interaction" nil t nil)

(autoload 'rustic-promote-module-into-dir "rustic-interaction" "\
Promote the module file visited by the current buffer into its own directory.

For example, if the current buffer is visiting the file `foo.rs',
then this function creates the directory `foo' and renames the
file to `foo/mod.rs'.  The current buffer will be updated to
visit the new file." t nil)

(autoload 'rustic-beginning-of-defun "rustic-interaction" "\
Move backward to the beginning of the current defun.

With ARG, move backward multiple defuns.  Negative ARG means
move forward.

This is written mainly to be used as `beginning-of-defun-function' for Rust.
Don't move to the beginning of the line. `beginning-of-defun',
which calls this, does that afterwards.

\(fn &optional ARG REGEX)" t nil)

(autoload 'rustic-end-of-defun "rustic-interaction" "\
Move forward to the next end of defun.

With argument, do it that many times.
Negative argument -N means move back to Nth preceding end of defun.

Assume that this is called after beginning-of-defun. So point is
at the beginning of the defun body.

This is written mainly to be used as `end-of-defun-function' for Rust." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "rustic-interaction"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-interaction.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-interaction.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-interaction" '("rustic-")))

;;;***

;;;***

;;;### (autoloads nil "rustic-popup" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-popup.el"
;;;;;;  "def91577571f92f44767441b953ef94a")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-popup.el

(autoload 'rustic-popup "rustic-popup" "\
Setup popup.
If directory is not in a rust project call `read-directory-name'." t nil)

(autoload 'rustic-popup-invoke-popup-action "rustic-popup" "\
Execute commands which are listed in `rustic-popup-commands'.

\(fn EVENT)" t nil)

(autoload 'rustic-popup-default-action "rustic-popup" "\
Change backtrace and `compilation-arguments' when executed on
corresponding line." t nil)

(autoload 'rustic-popup-cargo-command-help "rustic-popup" "\
Display help buffer for cargo command at point." t nil)

(autoload 'rustic-popup-kill-help-buffer "rustic-popup" "\
Kill popup help buffer and switch to popup buffer." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "rustic-popup"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-popup.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-popup.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-popup" '("rustic-popup-")))

;;;***

;;;***

;;;### (autoloads nil "rustic-racer" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-racer.el"
;;;;;;  "192fccc7c2a5c309f3550d92e3d525a2")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-racer.el

(autoload 'rustic-racer-describe "rustic-racer" "\
Show a *Racer Help* buffer for the function or type at point." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "rustic-racer"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-racer.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-racer.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-racer" '("racer-src-button" "rustic-racer-")))

;;;***

;;;***

;;;### (autoloads nil "rustic-util" "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-util.el"
;;;;;;  "ba197a0c1dc9f582228fb72f10153e41")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-util.el

(autoload 'rustic-cargo-fmt "rustic-util" "\
Use rustfmt via cargo." t nil)

(autoload 'rustic-format-buffer "rustic-util" "\
Format the current buffer using rustfmt.

Provide optional argument NO-STDIN for `rustic-before-save-hook' since there
were issues when using stdin for formatting.

\(fn &optional NO-STDIN)" t nil)

(autoload 'rustic-analyzer-macro-expand "rustic-util" "\
Default method for displaying macro expansion results.

\(fn RESULT)" t nil)

(autoload 'rustic-rustfix "rustic-util" "\
Run 'cargo fix'." t nil)

(autoload 'rustic-playpen "rustic-util" "\
Create a shareable URL for the contents of the current region,
src-block or buffer on the Rust playpen.

\(fn BEGIN END)" t nil)

(autoload 'rustic-open-dependency-file "rustic-util" "\
Open the 'Cargo.toml' file at the project root if the current buffer is
visiting a project." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "rustic-util"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-util.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-util.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-util" '("rustic-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-babel.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-cargo.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-common.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-compile.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-flycheck.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-interaction.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-popup.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-racer.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic-util.el"
;;;;;;  "../../../../../.emacs.d/elpa/rustic-20200304.2128/rustic.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rustic-autoloads.el ends here
