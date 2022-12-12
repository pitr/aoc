alf ← ⎕UCS 32+⎕UCS⎕A
inp ← ⊃⎕NGET'in/04.txt'1
sectors ← {⍎⍵/⍨⍵∊⎕D}¨ inp
checksum ← {¯1↓(1+⍵⍳'[')↓⍵}¨ inp
names ← {'-'~⍨⍵↑⍨⌊/⍵⍳⎕D}¨ inp
sig ← {5↑{⍵[⍋⌽⍵;0]}{⍺,100-≢⍵}⌸⍵[⍋alf⍳⍵]}

⎕← +/sectors/⍨checksum≡¨sig¨names

dec ← {alf[26|⍺+alf⍳⍵]}
⎕← sectors/⍨ sectors ('northpoleobjectstorage'≡dec)¨ names
