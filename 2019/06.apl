src dst ← ↓⍉↑')'(≠⊆⊢)¨⊃⎕NGET'in/06.txt'1

pa ← dst⍳src
⎕← +/{1+⍵[pa],¯1}⍣≡0,pa≠pa
⎕← (≢∪~∩)/1↓¨{⍵=≢pa:⍬ ⋄ ⍵,∇pa[⍵]}¨dst⍳'YOU' 'SAN'
