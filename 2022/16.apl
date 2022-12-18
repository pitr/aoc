names flows links ← ↓⍉↑ {(⊃⍵)(⍎1⊃⍵)(2↓⍵)}∘('[A-Z]{2}|(\d+)'⎕S'&')¨⊃⎕NGET'in/16.txt'1
flows ← flows[sort ← ⍒flows]
names ← names[sort]
links ← (names∘⍳)¨links[sort]
start ← names⍳⊂'AA'
mask  ← ⍳×/1+0<flows

dp ← 30 (≢names) (≢mask) ⍴0  ⍝ days ; names ; valve masks (only non-zero)
_← (1↓⍳30) ∘.{
    day valve ← ⍺⍵
    on ← ⍸(0<day)∧⊣⌿2(2*valve)⊤mask
    dp[day;valve;on] ⌈← dp[day-1;valve;on-2*valve] + day×flows[valve]
    dp[day;valve;]   ⌈← ⌈⌿ dp[day-1;valve⊃links;]
    0
} ⍳≢names

⎕← ⌈/dp[29;start;]
⎕← ⌈/ (⊢+⌽) dp[25;start;]
