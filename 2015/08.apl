f ← ⊃⎕NGET'in/08.txt'1

⎕← (≢∊f)-≢('\\(.)'⎕R'\1')('\\x[a-f0-9]{2}'⎕R'X')∊{¯1↓1↓⍵}¨f
⎕← (≢∊f) -⍨ +/2+≢∘('"'⎕R'\\"')∘('\\'⎕R'\\\\')¨f
