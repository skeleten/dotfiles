;;; ob-promel.el --- org-babel functions for promela evaluation

;; Copyright (C) Jan Pelle Thomson

;; Author: Jan Pelle Thomson
;; Keywords: literate programming, reproducible research
;; Homepage: https://orgmode.org
;; Version: 0.01

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Requirements:

;;; TODO
;;; - Add possibility to add extra-flags

;;; Code:
(require 'ob)
(require 'ob-ref)
(require 'ob-comint)
(require 'ob-eval)
;; possibly require modes required for your language

;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("promela" . "pml"))

;; optionally declare default header arguments for this language
(defvar org-babel-default-header-args:promela '())

(defun org-babel-execute:promela (body params)
  (let ((session (cdr (assoc :session params)))
	(tmp (org-babel-temp-file "promela-"))
	(out (org-babel-temp-file "promela-out-")))
    (with-temp-file tmp (insert body))
    (ob-promela--eval session params tmp out)))

(defun ob-promela--eval (session params file out)
  (call-process "spin" nil `(:file ,out) nil
		file)
  (ob-promela--read-file-to-string out))

(defun ob-promela--read-file-to-string (path)
  (with-temp-buffer
    (insert-file-contents path)
    (buffer-string)))

(provide 'ob-promela)
;;; ob-promela.el ends here
