rules msg ← {(×≢¨⍵)⊆⍵}⊃⎕NGET'in/19.txt'1
rules ← {
    t ← {⍵⊆⍨⍵≠' '}⍵~':"'
    r ← ⍎⊃t
    (1 0⊃t)∊'ab': r,1⊃t                 ⍝ rule a/b
    r,⍎¨¨{⍵⊆⍨⍵≢¨⊂,'|'}1↓t               ⍝ rule A B | C D
}¨rules
rules ← (1↓¨rules)@i⊢0/⍨1+⌈/i←⊃¨rules   ⍝ sort by rule ID

f ← {1=≡v←⍵⊃rules:∊,v ⋄ ⊃rules[⍵]←⊂∊'(?:', (∊{⍺,'|',⍵}/∇¨¨v), ')'}

⎕← +/≢¨('^',(f 0),'$')⎕S''¨msg
⎕← +/≢¨('^',(f 42),'+(',(f 42),'(|(?1))',(f 31),')$')⎕S''¨msg
