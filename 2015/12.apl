f ← ⊃⊃⎕NGET'in/12.txt'1

nums ← ('-',⎕D)∘(⍎¨∊⍨⊆⊢)
dpth ← 1+-⌿+\'{}'∘.=f
mask ← ~⊃∨/{(⌽∧\⌽dpth[⍵]≤⍵↑dpth),∧\dpth[⍵]≤⍵↓dpth}¨⍸':"red"'⍷f

⎕← +/ nums f
⎕← +/ nums mask/f
