FIX ← {
    bad ← {⍵⌿⍨>/⍵}⍵⍳o⌿⍨∧/o∊⍵
    0=≢bad: ⍵
    ∇⍵[bad[0;1 0]]@(bad[0;])⊢⍵
}

o p ← {(×≢¨⍵)⊆⍵}⊃⎕NGET'in/05.txt'1
o ← ⍎¨↑o(∊¨⊆¨⊣)⊂⎕D
P ← FIX¨p ← ⍎¨p

⎕← +/{⍵⊃⍨⌊.5×≢⍵}¨P/⍨P≡¨p
⎕← +/{⍵⊃⍨⌊.5×≢⍵}¨P/⍨P≢¨p
