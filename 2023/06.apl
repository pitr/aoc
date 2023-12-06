f ← {(⍵∊⎕D)⊆⍵}¨⊃⎕NGET'in/06.txt'1

⍝ g←{+/⍵<(⍺-i)×i←⍳⍺} ⍝ brute force
'roots'⎕CY'dfns'
g ← {-⍨/⌊roots¯1⍺(-⍵)}
⎕← ×/⊃g¨/⍎¨¨f
⎕← ⊃g/(⍎∊)¨f
