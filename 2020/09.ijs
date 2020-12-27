load 'aoc.ijs'

n =: ".&>'b'in'09'               NB. load
P =: 6+20*1000=#n                NB. partition size is 6 or 26 based on input size

NB. find ::: ys y -> returns y if 2 numbers in ys sum to y, else 0
find =: 0:`{: @. (2 > }: +/@e. {: - }:)

[R =: {.0-.~P find\n             NB. part 1

NB. sum ::: ys -> returns 1 sum of min and max of a prefix of ys whose total sum is R
sum =: (R = +/\.) +/@:* <./\. + >./\.

+/sum\ n{.~n i.R                 NB. part 2