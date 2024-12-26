parse ← {(⍺÷⍨≢f)⍺⍴f←'AB C D'⍳⊃⊃⎕NGET('in/',⍵,'.txt')1}
solve ← {+/(+/6|⍵)+{⍵×⍵-1}+/6≠⍵}

⎕← solve 1parse'01_1'
⎕← solve 2parse'01_2'
⎕← solve 3parse'01_3'
