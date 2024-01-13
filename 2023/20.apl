F ← ' ->,'∘((~∊⍨)⊆⊢)¨⊃⎕NGET'in/20.txt'1
N ← ('%&'~⍨⊃)¨F
G ← (N⍳1↓⊢)¨F
types ← 'b%&'⍳(⊃⊃)¨F
rx ← ≢G
flips ← rx/0
conj ← 0@(⊃,/G,¨¨⍳rx)⊢(2/1+rx)⍴1
rxI ← ⍸0=conj[conj[rx;]⍳0;]
rxC ← 0×rxI
counts ← 0 0

press ← {
    0=≢⍵: ⍺⍺+1
    source cur pulse ← ⊃⍵
    counts[pulse]+← 1
    rx=cur: ∇1↓⍵
    0=t←types[cur]: ∇1↓⍵,{cur,⍵,pulse}¨cur⊃G
    1 1≡t pulse: ∇1↓⍵
    1=t: ∇1↓⍵,(cur⊃G){cur,⍺,⍵}¨flips[cur]←~flips[cur]
    conj[cur;source] ← pulse
    rxC ⌈← (1=conj[cur;rxI])×⍺⍺×rx∊cur⊃G
    ∇1↓⍵,(cur⊃G){cur,⍺,⍵}¨pulse ← ~∧/conj[cur;]
}
start ← ⊂¯1(types⍳0)0
⎕← {
    n ← ⍵ press start
    1e3=⍵: ∇n⊣ ⎕←×/counts
    ∧/×rxC: ×/rxC
    ∇n
} 1
