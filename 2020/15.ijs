load 'aoc.ijs'

n =: ".LF-.~in'15'      NB. load and parse

NB. next ::: y is current index, produce next number
solve =: 3 : 0
    mem =: y $ _
    mem =: (1+i.<:#n) (<<}:n)} mem

    last =: {:n

    i =: #n
    while. i<y do.
        next =. 0 >. i - last{mem
        mem =: i last} mem
        last =: next

        i =: i+1
    end.

    last
)

solve 2020              NB. part 1
solve 3e6               NB. part 2 (takes ~20s)