w ← 'zero' 'one' 'two' 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine'

l ← ⊃⎕NGET'in/01.txt'1

⎕← +/ {⍎∊1 ¯1↑¨⊂⍵∩⎕D}¨l
⎕← +/{10⊥∊1 ¯1↑¨{⍵~¨0}(⊂10|⎕D⍳⍵)⌈⌈⌿{⍵×⍳≢⍵}w⍷¨⊂⍵}¨l
