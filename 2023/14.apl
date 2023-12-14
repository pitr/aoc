f ← (1,⌽∘⍉)⍣4⊢'.#'⍳↑⊃⎕NGET'in/14.txt'1
F ← {(-¯1⊖n)+⍵+n←2×⍵<1⊖⍵=2}⍣≡
S ← {+/(⌽⍳≢⍵)+.×2=⍵}
⎕← S F f
scores←⍬ ⋄ {n⊣scores,←S⊢n←{⌽⍉F⍵}⍣4⊢⍵}⍣200⊢f
pattern ← 1+⍣{⍺(⊢≡⌽)(2×⍺)↑⌽scores}3
⎕← ((-pattern)↑scores)[pattern|1e9-1+≢scores]
