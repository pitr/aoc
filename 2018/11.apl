serial ← ⍎⊃⊃⎕NGET'in/11.txt'1

grid ← {¯5+⊃10 100⊤(⍺+10)×serial+⍵×⍺+10}/¨1+⍳300 300

max ← {(⌷∘total , +∘1)⊃⍸total= max←⌈⌿⌈/ total←⍵+⌿⍵+/grid}

1↓max 3
{(300-i),⍨ 1↓⊃⍵[i←⊃⍒⍵]}max¨300-⍳300
