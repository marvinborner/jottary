# Jotter

Jotter (pronounced /dʒɑt.ər/) is a Turing tarpit and “an even better
Gödel-numbering” than its “sister language”
[Jot](https://esolangs.org/wiki/Jot).

## Semantics of Jotter

    []    -> I
    [F0]ₗ -> (S[F]ᵣ)
    [F0]ᵣ -> ([F]ₗS)
    [F1]ₗ -> (K[F]ᵣ)
    [F1]ᵣ -> ([F]ₗK)

`[F]` converts the Jotter program `F` to combinatory logic. The
associativity toggles between left and right (denoted by `ₗ/ᵣ`),
starting with the `ₗ` state.

## Jot vs. Jotter

Jotter has exactly the same (regular) syntax as Jot, including support
of the null program.

Every Jot program can easily be translated to Jotter:

    []   ->             -> I
    [F0] -> ???
    [F1] -> ???

Therefore Jotter is *Turing complete*.
