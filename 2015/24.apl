'cmat'⎕CY'dfns'

n ← ⍎¨⊃⎕NGET'in/24.txt'1
solve ← {
    sz ← (+/n)÷⍵
    ⌊/ {⌊/×/r⌿⍨sz=+/r←n[⍵ cmat ≢n]}¨ ⍳¯1+⌊(≢n)÷⍵
}

⎕← solve¨ 3 4
