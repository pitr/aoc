load 'aoc.ijs'

n =: in'07'                                            NB. load
V =: a: , ([: < [ {.~ 1 { [: I. ' ' = ]) ;. _2 n       NB. vertices

get =: ([: ". 2 {. ]) , V i. [: < 2 }. ]
'W G' =: ({."1 ; {:"1) 0 , ([: get@> '\d+ \w+ \w+' rxall ]) ;. _2 n
gold =: <'shiny gold'

NB. up ys ::: goes up the bags and adds any that are reachable
up =: +. G +./"1@e.~"1 I.

<:+/ up^:_ gold=V                                      NB. part 1

NB. down y ::: recursively finds number of bags that y{V can contains (excluding self)
down =: monad : 0 M.
    vs =. 0 -.~ y{G
    ws =. 0 -.~ y{W
    if. 0=#vs do. 0
    else.
        bags =. >:down"0 vs
        +/bags*ws
    end.
)

down V i. gold                                         NB. part 2