f ← ⊃⎕NGET'in/02.txt'1
d ← {'red' 'green' 'blue'∘.{⍎'0',∊('(\d+) ',⍺)⎕S'\1'⊢⍵}';'(≠⊆⊢)⍵}¨f

⎕← +/1+⍸{∧/12 13 14∧.≥⍵}¨d
⎕← +/×/↑⌈/¨d
