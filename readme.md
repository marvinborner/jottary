# Jotter

Jotter (pronounced /dʒɑt.ər/) is a Turing tarpit and an even better
Gödel-numbering than its sister language
[Jot](https://esolangs.org/wiki/Jot).

## Semantics of Jotter

    []    -> I
    [F0]ₗ -> (S[F]ᵣ)
    [F0]ᵣ -> ([F]ₗS)
    [F1]ₗ -> (K[F]ᵣ)
    [F1]ᵣ -> ([F]ₗK)

`[F]` converts the Jotter program `F` to combinatory logic. The
associativity toggles between left and right (denoted by `ₗ/ᵣ`).

The starting state depends on the length of the program: `ₗ` if
`len % 2 == 0` (even) and `ᵣ` if `len % 2 == 1` (odd). Don’t worry, this
only forces the core (the empty string, `I`) to always be on the left
side of the application.

## Jot vs. Jotter

Jotter has exactly the same (regular) syntax as Jot, including support
for the null program.

Every Jot program can easily be translated to Jotter:

    []   ->       -> I
    [F0] -> [F]01 -> ([F]S)
    [F1] -> ???

Therefore Jotter is *Turing-complete*.
