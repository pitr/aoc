parse ← {(⍺÷⍨≢f)⍺⍴f←'AB C D'⍳⊃⊃⎕NGET('in/01_',⍵,'.txt')1}
solve ← {+/(+/6|⍵)+{⍵×⍵-1}+/6≠⍵}

⎕← solve 1parse'1'
⎕← solve 2parse'2'
⎕← solve 3parse'3'
