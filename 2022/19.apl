plans ← { ↓0⍪(⌽∘.=⍨⍳4),⍨-↑(¯4↑⊃⍵)(¯4↑1⊃⍵)(¯4↑⍵[3 2])(0,1⌽⍵[4 5],0) }¨ ⎕D∘(⍎¨1↓∊⍨⊆⊢)¨ ⊃⎕NGET'in/19.txt'1

run ← {
    days cost ← ⍺⍵
    ⊃⊃{{⍵[(1e3⌊≢⍵)↑⍒4(↓+↑)¨⍵]}∪⊃,/{
        (⊂8↑(4/0 1)/⍵) + {⍵/⍨0∧.≤¨⍵} cost + ⊂⍵
    }¨⍵}⍣days⊂¯8↑1             ⍝ inventory(geode,obsidian,clay,ore) robots(geode,obsidian,clay,ore)
}

⎕← +/ (1+⍳≢plans) × 24 run¨ plans
⎕← ×/ 32 run¨ 3↑plans
