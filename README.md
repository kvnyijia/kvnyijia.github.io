
## Prerequisite

* The Haskell tool [Stack](https://docs.haskellstack.org/en/stable/README/)
* ghc (Stack's dependency)

for your quick reference
```bash
$ brew install ghc
$ brew install haskell-stack
```

## How to Build

```bash
$ stack build              # Compile site.hs
$ stack site exec build    # Generate source code for the sites
$ stack site exec watch    # Preview on localhost
```
