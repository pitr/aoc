passes ← {⊃,/' '∘(≠⊆⊢)¨⍵}¨ ((×≢¨)⊆⊢)⊃⎕NGET'in/04.txt'1

⎕← +/present←{7=≢'byr' 'iyr' 'eyr' 'hgt' 'hcl' 'ecl' 'pid' ∩ 3↑¨⍵}¨passes

within ← (≤⍥⊃) ∧ (≥⍥(⊢/))
byr ← 1920 2002 within ⍎
iyr ← 2010 2020 within ⍎
eyr ← 2020 2030 within ⍎
hgt ← {'cm'≡u←¯2↑⍵: 150 193 within ⍎¯2↓⍵ ⋄ 'in'≡u: 59 76 within ⍎¯2↓⍵ ⋄ 0}
hcl ← 'ok' ≡ ('^#[0-9a-f]{6}$'⎕R'ok')
ecl ← 'amb' 'blu' 'brn' 'gry' 'grn' 'hzl' 'oth' ∊⍨ ⊂
pid ← 'ok' ≡ ('^[0-9]{9}$'⎕R'ok')
cid ← 1⍨

⎕← +/(∧/⍎¨)¨(':(.*)'⎕R' ''\1''')¨¨present/passes
