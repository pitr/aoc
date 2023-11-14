'parse'⎕CY'max'

E ← {'×'@(⍸w='*')⊢w←⍵/⍨⍵≠' '}¨⊃⎕NGET'in/18.txt'1
⎕← +/⍎¨'\(' '\)'⎕R(,¨')(')¨⌽¨E

eval ← { 1=≢⍵: ⍵ ⋄ (⍎⊃⍵)/eval¨1↓⍵ }

⎕← +/{eval'×+'parse⍵}¨E
