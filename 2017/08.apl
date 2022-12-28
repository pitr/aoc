vars op1 val1 _ other op2 val2 ← ↓⍉↑' '(≠⊆⊢)¨⊃⎕NGET'in/08.txt'1
op1 ← '-+'[op1≡¨⊂'inc']
op2   ← '≤=≥<≠>'[('<=' '==' '>=' (,'<') '!=' (,'>'))⍳op2]
code ← ⊃,¨/vars '←' vars op1 (⍕∘⍎¨val1) '×' other op2 (⍕∘⍎¨val2)
{⍎⍵,'←0'}¨∪vars
results ← ⍎¨code

⎕← ⌈/⍎¨∪vars,other
⎕← ⌈/results
