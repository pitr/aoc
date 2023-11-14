f ← ('([A-Z])'⎕R'\1 ')⊃⎕NGET'in/12.txt'1

pos ← 0 ⋄ N ← {pos-←0j1×⍵} ⋄ W ← {pos-←⍵} ⋄ L ← {dir×←0j¯1*⍵÷90}
dir ← 1 ⋄ S ← {pos+←0j1×⍵} ⋄ E ← {pos+←⍵} ⋄ R ← {dir×←0j1 *⍵÷90}
F ← {pos+←dir×⍵}

⎕← +/|9 11○pos⊣⍎¨f

pos ← 0     ⋄ N ← {dir-←0j1×⍵} ⋄ W ← {dir-←⍵}
dir ← 10j¯1 ⋄ S ← {dir+←0j1×⍵} ⋄ E ← {dir+←⍵}

⎕← +/|9 11○pos⊣⍎¨f
