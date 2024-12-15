G M ← {⍵⊆⍨×≢¨⍵}⊃⎕NGET'in/15.txt'1
M ← ¯1 1 0j¯1 0j1['<>^v'⍳∊M]

wall box robot ← '#O@'∘.{+/↑0j1 1∘×¨⍸⍺=⍵}⊂↑G
move ← {
    m ← ⍺{∪⍵,box∩⍺+⍵}⍣≡⍵
    ∨/(⍺+m)∊wall: ⍵
    ⍵+ box[⍸box∊m] +← ⍺
}
⎕← +/∊100×@0⊢11 9∘.○box⊣ move/⌽robot,M

G ← ,/'##' '..' '[]' '@.'['#.O@'⍳↑G]
wall box boxr robot ← '#[]@'∘.{+/↑0j1 1∘×¨⍸⍺=⍵}⊂↑G
move ← {
    m ← ⍺{∪⍵,∊box boxr/⍨¨box boxr∨.∊⊂⍺+⍵}⍣≡⍵
    ∨/(⍺+m)∊wall: ⍵
    ⍵+ box[⍸box∊m] +← boxr[⍸boxr∊m] +← ⍺
}
⎕← +/∊100×@0⊢11 9∘.○box⊣ move/⌽robot,M
