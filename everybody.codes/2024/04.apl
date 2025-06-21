parse ← {⍎¨⊃⎕NGET('in/04_',⍵,'.txt')1}

solve ← {+/|⍵-⍺⍺⍵}
med  ← ⊢⌷⍨⍋⌷⍨(⌊.5×≢) ⍝ median is optimal just like AoC 2021 day 7 part 1

⎕←  ⌊/ solve parse'1'
⎕←  ⌊/ solve parse'2'
⎕← med solve parse'3'
