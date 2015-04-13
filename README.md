# emacs.d

This is an emacs config that started in 1994 and has been
re-written from the ground up a few times as package management
approaches have evolved.

It is currently geared towards lisp development, but I expect to add
support for erlang and haskell over time.

The focus is to provide a "batteries included" configuration for
development that includes auto-completion and integrated
documentation.

## Overriding configuration

In order to override parts of the configuration, create a directory
named the same as your user name in .emacs.d and add .el files
containing the overrides. All files in this directory will be loaded
after the rest of the configuration has been loaded.

## Requirements

* Emacs 24.4 or greater

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the
`init.el` contained in this repo ends up at `~/.emacs.d/init.el`.
Create a symlink from profiles.clj to `~/.lein/profiles.clj`.

The easiest way is to do this is:

````
git clone https://github.com/sandhu/emacs.d ~/.emacs.d
ln -s ~/.emacs.d/profiles.clj ~/.lein/profiles.clj
````

Upon starting up Emacs for the first time, the third-party packages
will be automatically downloaded and installed.


## References
This config has been heavily inspired by:
* Magnar Sveen - https://github.com/magnars/.emacs.d
* Steve Purcell - https://github.com/purcell/emacs.d
