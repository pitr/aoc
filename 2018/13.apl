map ← ↑⊃⎕NGET'in/13.txt'1

⍝ carts
D ← 0j¯1 0j1 1 ¯1 ⍝ '<>v^'
positions   ← +/¨ (⊂1 0j1) × ⍸map∊'<>v^'
dirs        ← D[('<>v^'⍳,map)~4]
turns       ← (≢dirs)⍴0
alive       ← (≢dirs)⍴1

left    ← 0j1∘×
right   ← 0j¯1∘×
slash   ← 0j¯1∘÷
slosh   ← 0j1∘÷

⍝ print coordinates and map
coord ← (⊣,',',⊢)⍥⍕/11 9∘○
show ← {'<>v^'[D⍳alive/dirs]@((⊂9 11)○alive/positions)⊢'|'@(⍸map∊'v^')⊢'-'@(⍸map∊'<>')⊢map}

tick ← {
    ⍝ update positions and alive
    crashes ← ∊{
        0=alive[⍵]: ⍬
        p d ← positions[⍵],dirs[⍵]
        alive[⍵] ∧ (p+d)∊alive/positions: {
            ⍝ mark as dead
            alive[⍵,⍸positions=p+d] ← 0
            p+d
        }⍵
        positions[⍵] +← d
        ⍬
    }¨⍋positions
    c ← map[(⊂9 11)○positions]
    ⍝ update turns
    turns +← xing ← c='+'
    ⍝ update directions
    dirs ∘← left@(⍸xing∧1=3|turns)⊢right@(⍸xing∧0=3|turns)⊢dirs
    dirs ∘← slash@(⍸'/'=c)⊢slosh@(⍸'\'=c)⊢dirs
    ⍝ print crashes
    ×≢crashes: alive/positions⊣⎕←'1. crash at ', ⊃∘coord¨crashes
    positions
}

'2. last cart at: ', ⊃coord⊃tick⍣{1≥+/alive}⊢0
