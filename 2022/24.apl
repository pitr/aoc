offset ← ¯1j¯2
imag ← {+/0j1 1×⍵}
map ← '#'⍪ (↑⊃⎕NGET'in/24.txt'1) ⍪'#'
shape ← ¯4 ¯2+⍴map
walls ← offset+ imag¨⍸'#'=map
dirs ← 1 ¯1 0j1 0j¯1['><v^'⍳(,map)~'.#']
step ← {+/0j1 1×⍤1⊢shape|⍤1⍉11 9∘.○dirs+⍵}
storms ← step offset+ imag¨⍸map∊'><v^'
start end ← offset+1 ¯1↑¨⊂imag¨⍸'.'=map

⍝ walk :: counter (from ∇∇ to) storms
walk ← {
    next ← (⊃∪/0 1 ¯1 0j1 0j¯1+⊂⍺⍺) ~ ⍵∪walls
    ⍵⍵∊next:     (1+⍺)(step ⍵)
    ⊃(next∇∇⍵⍵)/ (1+⍺)(step ⍵)
}

⎕← ⊃ ⊃(start walk end)/ 0 storms
⎕← ⊃ ⊃{a z←⍺ ⋄ ⊃(a walk z)/ ⍵}/ (2,/4⍴start,end),⊂0 storms
