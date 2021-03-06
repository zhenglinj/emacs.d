# Introduction

I fork this from [purcell/emacs.d](https://github.com/purcell/emacs.d ), and improved C/C++-mode Python-mode.

**EMACS => EMACS Make All Computer Smart :-)**

## Dependency

**[GNU Global](http://www.gnu.org/software/global)**
- Needed by `gtags`
- You use this tool to navigate the C/C++/Java/Objective-C code.
- Install through OS package manager

**[Clang](http://clang.llvm.org)**
- Needed by `auto-complete-clang`
- Install through OS package manager

**[Ctags](http://ctags.sourceforge.net)**
- Needed by many tags related plugins
- Install through OS package manager

**flake8/pylint/pyflakes**
- You need flake8/pylint/pyflakes for real time python syntax checker like flycheck
- Install pip through OS package manager, then `pip install flake8/pylint/pyflakes`
- On cygwin you need install `setuptool` in order to install `pip`.

**jedi, virtualenv, python-epc**
- `jedi` is used for python auto-complete
- `virtualenv` `epc` is needed by `jedi`
- `pip install jedi virtualenv epc`

**ropemacs, rope, ropemode, pymacs**
- `ropemacs` is a plugin for performing python refactorings in emacs
- `rope` library, `ropemode` and `pymacs` is needed by `ropemacs`
- `pip install ropemacs rope ropemode pymacs`
- [`pymacs` from github](https://github.com/pinard/Pymacs ) `git clone git@github.com:pinard/Pymacs.git`

**sdcv**
- StarDict Console Version
- install through OS package manager

**aspell or hunspell (RECOMMENDED), and corresponding dictionary (aspell-en, for example)**
- Needed by `flyspell`
- hunspell is the alternative of `aspell`. So you need only install either aspell or hunspell.
- Install through OS package manager

## Screenshot

![](./emacs.png )


-Added by zhenglinj

---

[![Build Status](https://travis-ci.org/purcell/emacs.d.png?branch=master)](https://travis-ci.org/purcell/emacs.d)

# A reasonable Emacs config

This is my emacs configuration tree, continually used and tweaked
since 2000, and it may be a good starting point for other Emacs
users, especially those who are web developers. These days it's
somewhat geared towards OS X, but it is known to also work on Linux
and Windows.

Emacs itself comes with support for many programming languages. This
config adds improved defaults and extended support for the following:

* Ruby / Ruby on Rails
* CSS / LESS / SASS / SCSS
* HAML / Markdown / Textile / ERB
* Clojure (with Cider and nRepl)
* Javascript / Coffeescript
* Python
* PHP
* Haskell
* Elm
* Erlang
* Common Lisp (with Slime)

In particular, there's a nice config for *autocompletion* with
[company](https://company-mode.github.io/), and
[flycheck](http://www.flycheck.org) is used to immediately highlight
syntax errors in Ruby, Python, Javascript, Haskell and a number of
other languages.

## Supported Emacs versions

The config should run on Emacs 23.3 or greater and is designed to
degrade smoothly - see the Travis build - but note that Emacs 24 and
above is required for an increasing number of key packages, including
`magit`, `company` and `flycheck`, so to get full you should use the
latest Emacs version available to you.

Some Windows users might need to follow
[these instructions](http://xn--9dbdkw.se/diary/how_to_enable_GnuTLS_for_Emacs_24_on_Windows/index.en.html)
to get TLS (ie. SSL) support included in their Emacs.

## Other requirements

To make the most of the programming language-specific support in this
config, further programs will likely be required, particularly those
that [flycheck](https://github.com/flycheck/flycheck) uses to provide
on-the-fly syntax checking.

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the
`init.el` contained in this repo ends up at `~/.emacs.d/init.el`:

```
git clone https://github.com/purcell/emacs.d.git ~/.emacs.d
```

Upon starting up Emacs for the first time, further third-party
packages will be automatically downloaded and installed. If you
encounter any errors at that stage, try restarting Emacs, and possibly
running `M-x package-refresh-contents` before doing so.


## Updates

Update the config with `git pull`. You'll probably also want/need to update
the third-party packages regularly too:

<kbd>M-x package-list-packages</kbd>, then <kbd>U</kbd> followed by <kbd>x</kbd>.

You should usually restart Emacs after pulling changes or updating
packages so that they can take effect. Emacs should usually restore
your working buffers when you restart due to this configuration's use
of the `desktop` and `session` packages.

## Adding your own customization

To add your own customization, use <kbd>M-x customize</kbd> and/or
create a file `~/.emacs.d/lisp/init-local.el` which looks like this:

```el
... your code here ...

(provide 'init-local)
```

If you need initialisation code which executes earlier in the startup process,
you can also create an `~/.emacs.d/lisp/init-preload-local.el` file.

If you plan to customize things more extensively, you should probably
just fork the repo and hack away at the config to make it your own!
Remember to regularly merge in changes from this repo, so that your
config remains compatible with the latest package and Emacs versions.

*Please note that I cannot provide support for customised versions of
this configuration.*

## Similar configs

You might also want to check out `emacs-starter-kit` and `prelude`.

## Support / issues

If you hit any problems, please first ensure that you are using the latest version
of this code, and that you have updated your packages to the most recent available
versions (see "Updates" above). If you still experience problems, go ahead and
[file an issue on the github project](https://github.com/purcell/emacs.d).

-Steve Purcell

<hr>

[![](http://api.coderwall.com/purcell/endorsecount.png)](http://coderwall.com/purcell)

[![](http://www.linkedin.com/img/webpromo/btn_liprofile_blue_80x15.png)](http://uk.linkedin.com/in/stevepurcell)

[sanityinc.com](http://www.sanityinc.com/)

[@sanityinc](https://twitter.com/)
