# Jottary

Jottary (pronounced /dʒɑteri/) is a unary Turing tarpit and an even
better Gödel-numbering than its sister language
[Jot](https://esolangs.org/wiki/Jot).

Read my [blog post](https://text.marvinborner.de/2023-10-05-15.html) for
more information.

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
