load 'aoc.ijs'

n =: 3, 2-/\ \:~ 0, ".'m'in'10'    NB. load, add leading 0, sort, do pair diffs, add trailing 3

*/ +/ n=/1 3                       NB. part 1 - product of num of 1s and 3s

tri =: 0 1 1 2 4 7 13 24 44        NB. first few tribonacci numbers

*/ tri{~ 2-~/\ I.3=n,3             NB. part 2 - product of tribonacci of num of contiguous 1s