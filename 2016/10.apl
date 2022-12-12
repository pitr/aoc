lines ← ' '(≠⊆⊢)¨⊃⎕NGET'in/10.txt'1

output ← bots ← instrs ← 300↑⊂⍬

{ val bot ← ⍎¨⍵[1 5] ⋄ bots[bot] ,← val }¨    lines/⍨{'value'≡⊃⍵}¨lines
{ instrs[⍎1⊃⍵] ← ⊂(5⊃⍵)(⍎6⊃⍵)(10⊃⍵)(⍎11⊃⍵) }¨ lines/⍨{'value'≢⊃⍵}¨lines

_←{
    bot ← (≢¨bots)⍳2
    bot=≢bots: ⍵
    vals ← bot⊃bots
    bots[bot] ← ⊂⍬
    tolow low tohi hi ← bot⊃instrs
    _ ← (1 0 1 0⊂bot⊃instrs) {
        'bot'≡⊃⍺: ,bots[1⊃⍺] ,← ⍵
        ,output[1⊃⍺] ← ⍵
    }¨ (⌊/,⌈/) vals
    17 61≡(⌊/,⌈/) vals: {⎕←bot ⋄ ⍵}bots
    bots
}⍣≡ bots
⎕← ×/3↑output
