f ← {(~⍵∊' =[]')⊆⍵}¨⊃⎕NGET'in/14.txt'1

mask ← { MZ∘←'0'=⊃⍵ ⋄ MO∘←'1'=⊃⍵ ⋄ 0 }
mem ← { k v ← ⍎¨⍵ ⋄ M[k] ← 2⊥MO∨(~MZ)∧(36/2)⊤v }
M←1e5/0 ⋄ {(⍎⊃⍵)1↓⍵}¨f ⋄ ⎕←+/M

mask ← { MZ∘←'0'=⊃⍵ ⋄ MO∘←'1'=⊃⍵ ⋄ MF∘←2⊥f⍀(n/2)⊤⍳2*n←+/f←'X'=⊃⍵ ⋄ 0 }
mem ← { k v ← ⍎¨⍵ ⋄ k←MF+2⊥(~MO⍱MZ)∧MO∨(36/2)⊤k ⋄ V,←v/⍨≢K,←k }
K←V←⍬ ⋄ {(⍎⊃⍵)1↓⍵}¨f ⋄ ⎕←+/V/⍨⌽≠⌽K