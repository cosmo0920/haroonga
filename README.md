Haroonga
===

[![Build Status](https://travis-ci.org/cosmo0920/haroonga.svg?branch=master)](https://travis-ci.org/cosmo0920/haroonga)

Low level Haskell binding for Groonga.

## dependencies

* groonga 4.0.3+
* hsc2hs
* and some cabal packages (see: haroonga.cabal)

## export module(s)

* Bindings.Groonga
* Bindings.Groonga.Raw
* Bindings.Groonga.Raw.Plugin
* Bindings.Groonga.Raw.Tokenizer
* Bindings.Groonga.CommandAPI
* Bindings.Groonga.Types

## How to install

Install Groonga.
For example, if you use Ubuntu Linux, see: http://groonga.org/docs/install/ubuntu.html#lts-precise-pangolin

And then,

```bash
$ cabal install haroonga
```

## Support Platform

* Currently, Haroonga supports __platform which has pkg-config command only__.
    - Linux
    - Mac OSX

## Haddock

* [Hackage](http://hackage.haskell.org/package/haroonga/docs/)
* [Github Pages](http://cosmo0920.github.io/haroonga/doc-index.html)
