# AoC 2020

First year using J, with Ruby as backup. APL added in 2023.

J solves 67% of all puzzles, Ruby - 47%, APL - 84%.

## Day 11
Part 1 simply uses 3x3 stencil and fixed point. Part 2 creates a connectivity matrix C where C[x;] are seats that the seat x is connected to. Seats get a 1-based sequence number in ravel order. For each seat location (i), their diagonal number(`(+/i)(-/i)`) as well as row and column are computed, and seats are grouped (`⌸`) on those. Along seats in each group, neighbour pairs are computes (`2,/`). Those neighbour pairs are made bi-directional and turned into an adjacency matrix in sequence order. After this, part 2 is simple with occupied seat mask and fixed point.
