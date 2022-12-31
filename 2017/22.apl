offset ← 1000
map ← '#'=↑⊃⎕NGET'in/22.txt'1
start ← +/1 0j1×offset-1+⌊(≢map)÷2
map ← origin ← (2/2×offset)↑(-2/offset)↑map

inf←0
_←{
    dir  ← (1⊃⍵)×0j¯1 0j1[s ← map⌷⍨r c ← 11 9○⊃⍵]
    inf +← ~s
    map[r;c] ← ~s
    (dir+⊃⍵) dir
}⍣1e4⊢ start 0j¯1
⎕← inf

map ← 2×origin
inf←0
_←{
    dir  ← (1⊃⍵)×0j¯1 1 0j1 ¯1[s ← map⌷⍨r c ← 11 9○⊃⍵]
    inf +← 1=s
    map[r;c] ← 4|1+s
    (dir+⊃⍵) dir
}⍣1e7⊢ start 0j¯1
⎕← inf
