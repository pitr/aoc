r ← 58|20+⎕UCS¨ ⊃⎕NGET'in/03.txt'1

⎕← +/∊{∪¨∩/↓2(2÷⍨≢⍵)⍴⍵}¨r
⎕← +/∊ ∪¨∩/(3÷⍨≢r)3⍴r