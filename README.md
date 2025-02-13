Personal website:

https://kvnyijia.github.io/

## Prerequisite

* [Hakyll](https://jaspervdj.be/hakyll/index.html)
* The Haskell tool [Stack](https://docs.haskellstack.org/en/stable/README/)
* ghc (Stack's dependency)

for your quick reference (if you're using MacOS)
```bash
$ brew install ghc
$ brew install haskell-stack
```

then install Hakyll
```bash
$ stack install hakyll
```

## How to Build

```bash
$ stack build              # Compile site.hs
$ stack exec site build    # Generate source code for the sites
$ stack exec site watch    # Preview on localhost
$ stack exec site rebuild
```
