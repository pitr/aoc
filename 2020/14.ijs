load 'aoc.ijs'

mask =: 7&}.
mem =: 2 5 ".&>@{ ;:
n =: |. ''; (mask`mem@.('e' = 1&{))&.>'b'in'14'      NB. load and parse

NB. set ::: sets mem[y1] = y2
set =: 3 : 0
    mem =: (] {~ [: I.@~: {."1) y,mem
)

NB. eval ::: takes mask and addr,val and updates mem
eval =: 4 : 0
    'zs oz' =. '01' =/x
    'addr val' =. y
    set addr, #. oz +. (-.zs) *. (36#2) #: val
)

run =: 4 : 0
    mask =. >y
    x =. >x
    if. 2 = #x do.
        mask eval x
        y
    else.
        <x
    end.
)

solve =: 3 : 0
    mem =: 2 0$0
    run/n
    +/{:"1 mem
)
solve''

NB. eval ::: takes mask and addr,val and returns indices to change
eval =: 4 : 0
    'ns xs' =. (-. ; 35 - I.) x='X'
    os =. x='1'
    masks =. (#:i.2^#xs) +/ . * x:2^xs
    'addr val' =. y
    addrs =. masks +/ #. ns *. os +. (36#2) #: addr
    set val,.~ addrs
)
solve''