lines ← {⍵⊆⍨~⍵∊' x='}¨ ⊃⎕NGET'in/08.txt'1

run ← {⊃{
    inst ← ⍺
    card ← ⍵
    'rect'≡⊃inst:    card⊣card[,⍳⌽⍎¨1↓inst] ← 1
    axis by ← ⍎¨inst[¯3 ¯1 + ≢inst]
    'column'≡1⊃inst: card⊣card[;axis] ← (-by)⌽card[;axis]
                     card⊣card[axis;] ← (-by)⌽card[axis;]
}/⌽(⊂⍺⍴0),⍵}

⎕← +/∊6 50 run lines
⎕← ' #'[6 50 run lines]
