f ← ↑{⍎¨⍵⊆⍨⍵∊'-',⎕D}¨⊃⎕NGET'in/24.txt'1
S E ← ⊃(7 27)(2e14 4e14)[10<≢f]

⎕← +/{
    x y dx dy ← f[⍺;0 1 3 4]
    u v du dv ← f[⍵;0 1 3 4]
    =/dy dv×du dx: 0
    s ← (-/dv du×x y-u v) ÷ -/dy dx×du dv
    t ← (-/dy dx×u v-x y) ÷ -/dv du×dx dy
    cx cy ← x y+dx dy×s
    cx cy E E s t ×.> S S cx cy 0 0
}/¨⍸∘.<⍨⍳≢f

solve ← {
    dx dy dz vx vy vz ← ⍺-⍵
    A ← 3 6⍴0 (-vz) vy 0 (-dz) dy vz 0 (-vx) dz 0 (-dx) (-vy) vx 0 (-dy) dx 0
    B ← (-/⍵[1 2]×⍵[5 4]) - (-/⍺[1 2]×⍺[5 4])
    B,← (-/⍵[2 0]×⍵[3 5]) - (-/⍺[2 0]×⍺[3 5])
    B,← (-/⍵[0 1]×⍵[4 3]) - (-/⍺[0 1]×⍺[4 3])
    A B
}
A B ← ⊃⍪¨/{f[0;] solve f[⍵;]}¨1 2
⎕← +/3↑(⌹A)+.×B
