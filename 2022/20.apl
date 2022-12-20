f ← ⍎¨⊃⎕NGET'in/20.txt'1

mix ← {
    i←⊃{ ⍺,((n-1)|nums[⍺]+⍵⍳⍺)⌽⍵~⍺ }/⌽(⊂⍳n),∊⍺/⊂⍳n←≢nums←⍵
    +/nums[i[n|(i⍳nums⍳0)+1e3×1+⍳3]]
}

⎕← 1  mix f
⎕← 10 mix f×811589153
