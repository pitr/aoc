lines ← ⊃⎕NGET'in/07.txt'1

sz ← ⍬                          ⍝ sizes of all dirs
sz,← ⊃{
    '$ cd ..'≡⍺:  1↓⍵ ⊣sz ,← ⊃⍵ ⍝ pop size of current dir, append to sz
    '$ cd'≡4↑⍺:   0,⍵           ⍝ push size of new dir
    ⎕D∊⍨⊃⍺:       ⍵ + ⍎(⍺∊⎕D)/⍺ ⍝ increment sizes of current and parent dirs
    ⍵                           ⍝ do nothing otherwise
}/⌽(⊂⍬),lines

⎕← +/sz/⍨sz≤ 1e5
⎕← ⌊/sz/⍨sz≥ ⌈/sz-4e7
