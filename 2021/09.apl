f ← ↑⍎¨¨⊃⎕NGET'in/09.txt' 1

⍝ applies ⍺⍺ for each element and its direct neighbours
window ← {∆ ← ⍺⍺ ⋄ {⍵[1;1] ∆ ,⍵×3 3⍴⍳2}⌺3 3⊢⍵}

+/1+ f[lows ← ⍸ ∧.> window 9-f] ⍝ part 1

×/3↑ {⍵[⍒⍵]} {≢⍵}⌸ 0~⍨, {⌈/⍺,⍵××⍺} window⍣≡ (2+⍳≢lows)@lows ⊢ 9≠f
⍝ ^ multiply first three
⍝       ^ largest
⍝             ^ sizes of
⍝                  ^ non-empty
⍝                        ^ basins
⍝                       filled-converged ^
⍝                     from numbered low points ^
⍝                                          disregarding peaks ^

