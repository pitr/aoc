s ← '!.'⎕R''⊃⊃⎕NGET'in/09.txt'1
g ← '<[^>]*>'⎕S'&'⊢s
s ← '<[^>]*>'⎕R''⊢s
⎕← +/(s='{')×-⌿+\'{}'∘.=s
⎕← +/(≢¨g)-2
