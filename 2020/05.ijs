load 'aoc.ijs'

#.'BR'e.~'m'in'05e'        NB. test: should be 567 119 820

n =: #.'BR'e.~'m'in'05'    NB. load
>./n                       NB. part 1
{.n-.~1+n                  NB. part 2