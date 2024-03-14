## f90format -- format Fortran source using fprettify

This package hooks up [fprettify](https://github.com/pseewald/fprettify) with Steve Purcell's [emacs-reformatter](https://github.com/purcell/emacs-reformatter) to format _modern_ Fortran source.

### Installation

`fprettify` is a command line tool and can be installed from `pypi`, `conda`, or other package manager. 

`emacs-reformatter` is an Emacs package and is available from GNU ELPA.

`f90format` is not (yet) in MELPA. Place the file `f90format.el` in a directory in your `load-path` and add `(require 'f90format)` at an appropriate location in your Emacs configuration.

### Bindings and hooks

No key binds or hooks are installed by default, see the comments in `f90format.el` for suggestions.

### Configuring fprettify

The `f90format` customization group includes the variable `f90format-args` which is a list of string. Its default is nil. See `fprettify --help` for a list of possibilities.

### License

I normally release everything I do to the public domain but as `emacs-reformatter` is under the terms of the GNU General Public License V3 (or later), so is `f90format`.
