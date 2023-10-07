# Jottary

Jottary (pronounced /dʒɑteri/) is a unary Turing tarpit and an even
better Gödel-numbering than its sister language
[Jot](https://esolangs.org/wiki/Jot).

Read my [blog post](https://text.marvinborner.de/2023-10-05-15.html) for
more information.

This project is basically just a slightly modified version of
[birb](https://github.com/marvinborner/birb).

## Performance

The [bruijn
implementation](https://github.com/marvinborner/bruijn/blob/main/samples/fun/jottary.bruijn):

``` bash
$ hyperfine "printf '1%.0s' {1..503} | bruijn -y jottary.bruijn"
    Time (mean ± σ):     756.4 ms ±  35.2 ms    [User: 1816.9 ms, System: 1735.2 ms]
    Range (min … max):   706.9 ms … 808.2 ms    10 runs
```

This implementation:

``` bash
$ hyperfine "jottary reduce <(printf '1%.0s' {1..503})"
  Time (mean ± σ):      10.8 ms ±   0.7 ms    [User: 1.7 ms, System: 9.0 ms]
  Range (min … max):     9.5 ms …  12.5 ms    163 runs
```

:rocket: incredible!! :tada:

## Transpiler

The transpiler converts binary lambda calculus to Jottary. It does this
by converting to SKI combinators, then to Jot, and finally to Jottary.
Aside from general inefficiency of LC-SKI conversion, the jottary
programs will grow *exponentially* compared to its Jot variant. For
example, the `id` program `0010` gets transpiled to 2089884 unary
symbols (260KB!).

## Usage

Install Haskell's stack. Then,

-   `stack run -- reduce file.jottary` or
    `stack run -- reduce <(echo 1111111)`
-   `stack run -- transpile <(echo 0010)` to transpile the `id` program
-   `stack install` so you can enjoy `jottary` from anywhere
