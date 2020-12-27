load 'aoc.ijs'

m =: '#'='m'in'03'      NB. parse

go =: [ +/@:{~ $@[ <"1@|:@:| ] */ $@[ i.@>.@{.@:% ]


m go 1 3                      NB. part 1
*/_2 m&go\"."0'1113151721'    NB. part 2


NB. Learnings
NB. f^:a: x   call f(f(f(x))) until 0, return all
NB. cut       split by (default by blank)
NB. ss        search
NB. a|b       b mod a
NB. a{b       `b[x] for x in a` if a is array of coord boxes
NB. _2 ]\ y   group y into groups of 2