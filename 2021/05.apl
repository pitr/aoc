f ← {2 2⍴ ⍎¨ (⍵∊⎕D)⊆⍵}¨ ⊃⎕NGET'in/05.txt'1

coords ← {⊃,¨/ {⍺- (×d)× ⍳1+| d←⍺-⍵}⌿⍵} ⍝ all coords between two points
score ← {+/ 1< {≢⍵}⌸ ⊃,/ ⍵}             ⍝ count repetitions

score coords¨ ((∨/=⌿)¨f)/f  ⍝ part 1
score coords¨ f             ⍝ part 2
