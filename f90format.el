;;; f90format.el --- Reformat modern fortran source using fprettify -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Troy Brumley

;; Author: Troy Brumley <blametroi@gmail.com>
;; Keywords: languages
;; URL: https://github.com/blametroi/f90format
;; Version: 0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides commands and a minor mode for easily reformatting modern
;; free form Fortran source (F90+) using fprettify. This started as a
;; copy and global change sql to fortran of Steve Purcell's sqlformat.
;; I've tweaked a few things along the way. Any mistakes are mine.
;;
;; Customise the `f90format-command' and `f90format-args' as needed.
;; As long as the command is availalbe in the path, reads from
;; standard input, and writes to standard output, things should work
;; well.
;;
;; To use fprettify with three character indent and a space around the
;; member selector character `%' you could do the following:
;;
;;     (setopt f90format-command 'fprettify)
;;     (setopt f90format-args '("-w 4" "-i 3"))
;;
;; These options are customizable.
;;
;; Then call `f90format', `f90format-buffer' or `f90format-region' as
;; convenient.
;;
;; Enable `f90format-on-save-mode' in buffers like this:
;;
;;     (add-hook 'f90-mode-hook 'f90format-on-save-mode)
;;
;; or locally to your project with a form in your .dir-locals.el like
;; this:
;;
;;     ((f90-mode
;;       (mode . f90format-on-save)))
;;
;; You might like to bind `f90format' or `f90format-buffer' to a key,
;; e.g. with:
;;
;;     (define-key 'f90-mode-map (kbd "C-c C-f") 'f90format)

;;; Code:

;; Minor mode and customisation

(require 'reformatter)

(defgroup f90format nil
	"Reformat free form Fortran using fprettify."
	:group 'f90format)

(defcustom f90format-command "fprettify"
	"Command used for reformatting.
This command should receive SQL input via STDIN and output the
reformatted SQL to STDOUT, returning an appropriate exit code."
	:type 'string)

(defcustom f90format-args '()
	"List of command-line args for reformatting command."
	:type '(repeat string))


;; Commands for reformatting

;;;###autoload (autoload 'f90format-buffer "f90format" nil t)
;;;###autoload (autoload 'f90format-region "f90format" nil t)
;;;###autoload (autoload 'f90format-on-save-mode "f90format" nil t)
(reformatter-define f90format
	:program f90format-command
	:args f90format-args
	:group 'f90format)

;;;###autoload
(defun f90format (beg end)
	"Reformat Fortran in region from BEG to END using `f90format-region'.
If no region is active, the current statement (paragraph) is reformatted.
Bug: this should format the current program, subroutine, or function. The
navigation needs review."
	(interactive "r")
	(unless (use-region-p)
		(setq beg (save-excursion
						 (backward-paragraph)
						 (skip-syntax-forward " >")
						 (point))
         end (save-excursion
                (forward-paragraph)
                (skip-syntax-backward " >")
                (point))))
	(f90format-region beg end (called-interactively-p 'any)))


(provide 'f90format)
;;; f90format.el ends here
