load 'aoc.ijs'

parse =: 3 : 0
    't m' =. ':'cut>y
    t =. ".>{:;:t
    m =. }.'#'&=;._2 m,LF
    ({. #.@, {: , {."1 ,: {:"1) m
)
[n =: parse &> LF2 splitstring in'20e'       NB. load

intersect =: e. # [

#@intersect/~"1 n

NB. FAIL, done in ruby