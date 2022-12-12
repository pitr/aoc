code ← ⊃⎕NGET'in/21.txt'1
to ← {⍺+⍳1+⍵-⍺}
swap ← {⌽@⍵⊢⍺}

⎕← ⊃{
    op ← 11↑⍺ ⋄ args ← 2↓(⍺≠' ')⊆⍺
    'swap positi'≡op: ⍵ swap ⍎¨args[0 3]
    'swap letter'≡op: ⍵ swap ⍵⍳∊args[0 3]
    'reverse pos'≡op: ⍵ swap ⊃to/⍎¨args[0 2]
    'rotate left'≡op: ⍵⌽⍨⍎⊃args
    'rotate righ'≡op: ⍵⌽⍨-⍎⊃args
    'move positi'≡op: ⍵[(⊃move)]((1⊃move){⍺⍺(↑⍪⍺⍪↓)⍵}) ((⊃move)↑⍵),(-(≢⍵)-1+⊃move←⍎¨args[0 3])↑⍵
    'rotate base'≡op: (-(i≥4)+1+i←⍵⍳4⊃args)⌽⍵
}/(⌽code),⊂'abcdefgh'

⎕← ⊃{
    op ← 11↑⍺ ⋄ args ← 2↓(⍺≠' ')⊆⍺
    'swap positi'≡op: ⍵ swap ⍎¨args[0 3]
    'swap letter'≡op: ⍵ swap ⍵⍳∊args[0 3]
    'reverse pos'≡op: ⍵ swap ⊃to/⍎¨args[0 2]
    'rotate left'≡op: ⍵⌽⍨-⍎⊃args
    'rotate righ'≡op: ⍵⌽⍨⍎⊃args
    'move positi'≡op: ⍵[(1⊃move)]((⊃move){⍺⍺(↑⍪⍺⍪↓)⍵}) ((1⊃move)↑⍵),(-(≢⍵)-1+1⊃move←⍎¨args[0 3])↑⍵
    'rotate base'≡op: ((5×0=2|i)+⌈.5×1+(≢⍵)|¯1+i←⍵⍳4⊃args)⌽⍵
}/code,⊂'fbgdceah'
