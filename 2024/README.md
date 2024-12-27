# AoC 2024

Done in APL.

Streamed on [Twitch](https://www.twitch.tv/pitrapen). Archived on [YouTube](https://www.youtube.com/playlist?list=PLUypSmvDdWt7mQJBGmkj4LE5Vu2_2g_kc).

See parent [README.md](../README.md) for setup.

## Day 1

Part 1 presorts each, and calculates the sum of absolute differences. Part 2 uses outer product to count the appearance of elements of one list in the other.

## Day 2

Part 1 uses 2-wise reduction to check for increases/decreases within range and positive/negative signums. Part 2 does the same, but runs on permutations where each report is excluded.

## Day 3

Regex to find multipliers, and in part 2 a global variable that indicates the mode (`e`) at each match.

## Day 4

Part 1 looks (`⍷`) for keywords in each of rows, columns (original matrix transposed), or all diagonals in both directions. Part 2 uses stencil (`⌺`) and checks for the keywords in both of the 2 main diagonals of each window.

## Day 5

`fixed` are `pages` in order using outer product to build individual rules that are checked against `rules`. Those pages that are in the right order will have an adjacency matrix with top right triangle marked, and sorting (`⍒`) fixes those that aren't. Then each part calculates the score (middle page number) for either correctly or incorrectly ordered updates.

## Day 6

Both parts use `walk` function that recursively walks the map. There are no optimizations, hence the performance is quite bad - ~30 seconds on my machine.

## Day 7

BFS, but instead of starting with 0 and going left to right, the solution space is reduced a lot by starting with the final number and going from the end. Multiply checks for divisibility, add checks that subtraction doesn't go into negative numbers, and concatenation checks for same digits (using log of 10). The final check is if any paths end up with 0.

## Day 8

Part 1 is done using outer product for each antenna against others of the same frequency to find antinodes. Part 2 is the same, except all multiples of distances are used to find antinodes.

## Day 9

Expansion of the disk in the solution uses slight modifications from the one used in the task description. While `12345` is described to expand into `0..111....22222`, `n` uses 1-based IDs, and 0 to represent free space - `100222000033333`. In part 1, files from the second half of the disk are copies (using `@`) in reverse into free space of the first half. For part 2, two additional arrays are used: `gi` for offsets of gaps and `gs` for corresponding gap sizes. Then, for each file ID in reverse, find the earliest gap of that size and move the file there, if possible. Gap sizes and offsets are updates to reflect remaining free space.

## Day 10

`p` stores locations of each digit, where `p[d]` is list of coordinates of that digit `d`. `t` uses BFS to compute a list of not deduplicated trailhead ends (9) for each of starting points (0). Part 1 then counts the sum of unique trailhead ends per each start, while part 2 counts not deduplicated ends.

## Day 11

`blink` is fairly self-explanatory. However, to avoid trying to store a huge list of numbered stones, the lanternfish trick is used to only store unique stone numbers and their count. `run` does all the accounting work, and is called however many times is needed for each part.

## Day 12

`a` is the adjacency vector - `a[i]` stores positions of neighbouring plants of the same type including self, where `i` is in ravel order. First, different plant types with the same letter name must be disambiguated. `p` is a [parent vector](https://asherbhs.github.io/apl-site/trees/parent-vectors.html) of forests by plant type, built using a [union-find algorithm](https://en.wikipedia.org/wiki/Disjoint-set_data_structure). It starts as a forest of 1-node trees that are first merged using 2-wise reductions of neighbours. Then each node is pointed directly at its type's root. `area` simply counts sizes of the types using `⌸`. Perimeter (`peri`) is the sum of neighbours that aren't of the same type, similarly grouped using ⌸ and parent vector. `side` instead calculates the number of corners, since their number is the same as sides for closed, Euclidean, 2D shapes without curves. Using stencil (`⌺`) and positions of corner pieces (`C`), 3 types of corners are identified - not touching same type, touching same type only diagonally, and touching same type everywhere BUT diagonally (for concave shapes). Again, the count of these corners is grouped using `⌸` and parent vector.

## Day 13

Matrix divide (`⌹`) solves linear equations, `⍵≡⌊⍵` checks for integer solutions. Rest of the code structures the input into the right shape and calculates score.

## Day 14

Part 1 is solved by moving `p` directly to position after 100 seconds using `p+v×100` and modulo. Quadrant split is done using signum of differences of p and mid point, and ⌸ to group by signum combinations. Part 2 was initially solved by looking for a filled 3x3 square using ⌺, which was replaced by a much faster search for contiguous lines of at least length 10 using `1∊10⌊⌿` in the first 1e4 seconds. Of course, `10⌊/` also works but is slower due to worse memory locality.

## Day 15

`M` are moves, represented as imaginary numbers. `w b r` are positions of walls, boxes and robot respectively, also as imaginary numbers. `next` performs one move of the robot (and all boxes, found using fixed point) and reduces the robot's initial position against the moves vector. In part 2 the x coordinates of `b r` are simply doubled, so only the left side of the box (ie `[` in `[]`) is tracked. Everything is exactly as in part 1, except fixed point for box finding now needs to account for the (untracked) right side of boxes.

## Day 16

`P` is a 4-dimentional ravel cost matrix - `P[i;d]` shows the cost to get to space `i` and direction `d` - which is calculated using rotations until a fixed point. As such, `⌊/P[E;]` shows shortest path to the end. `Q` is the same thing as `P` except it describes traveling backwards from E. Then part 2 is all positions where `P+Q` are equal to part 1.

## Day 17

`run` runs instructions as per VM description. `native` is decompiled, simplified and APL-ified code that runs much faster.

```apl

'cmpx'⎕CY'dfns'
⎕ ← cmpx 'run 0 1 2 3 a 0 0' 'native a'
 run 0 1 2 3 a 0 0 → 2.1E¯4 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
 native a          → 5.4E¯5 | -74% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
```

Part 2 is solved by "lock picking" the code using BFS by building up an 8-base solution.

## Day 18

`G` is a 1-dimentional ravel representation of the graph - `G[i]` shows all spaces i-th space is connected to. `skip` are spaces to skip. `bfs` finds shortest path by updating an array to a fixed point, where value at i is either -2 if space must be skipped, -1 if it hasn't been visited yet, otherwise - distance from start. It uses `G` to find next spaces to visit. Part 1 simply runs `bfs` with no skips, part 2 uses binary search to find the smallest amount of skip spaces that break the path.

## Day 19

Computes `c` - count of ways to design the patterns using the specified towels (`T`) - using a simple DFS with memoization (`K` for sub-pattern, `V` for count). Part 1 is then trivial thanks to signum primitive.

## Day 20

Positions are kept in ravel order. Path (`p`) is computed using a simple recursive function. Create outer product matrices for hamiltonian distances (`d`) and picosecond savings (`s`). Construction of distances avoids using a simpler `∘.{+/|⍺-⍵}⍨⍸` (or even `+/¨|∘.-⍨⍸`) as it gives `WS FULL` error (due to a ~100 million tiny boxed arrays being create) and processes one axis at a time. Both matrices use ravel order of points on the path (hence the use of `⍋`). Then find combinations of distances and savings needed.

## Day 21

Use a single map with both pads, since buttons are unique (except `A` which becomes `a` in the directional pad). `step` returns best path from `⍺` to `⍵` using directional pad buttons. `run` will take a pattern and create instructions for the previous robot by prepending `a` or `A` to it since all robots start there, and 2-wise reduce that just calls `step`. Further, `run` will use the lanternfish trick to keep a single copy and a count for repeating sequences.

## Day 22

For performance reasons due to absence of native bitwise XOR in APL, next secret (`next`) operates on 24-bit binary representation of all numbers (`N`) at the same time. Last digits of buyers at every iteration are accumulated in `P`. Part 1 is the sum of the result of `next⍣2000`. For part 2, sequences of 4-wise reduction of differences are stored in `S`. Mask of first instance of each sequence per buyer is stored in `M`. Next price after each sequence per buyer is in `N`. The final calculation is the maximum of sums of `N` grouped by sequence.

## Day 23

`V` are vertices, `E` is an adjacency matrix of edges. Part 1 is BFS from vertices that start with "t" traversed to depth 3. Duplicates are removed after sorting each path (`∪{⍵[⍋⍵]}¨`). Part 2 is a super simple search that always chooses the first valid neighbour, and is started at each vertex. For both parts, the next neighbour is always chosen of those that are connected to all previous vertices.

## Day 24

Part 1 is done by converting input to APL and eval-ing. Part 2 is done by finding instructions that don't fit into [the full adder circuit (with carry bit)](https://en.wikipedia.org/wiki/Adder_(electronics)).

## Day 25

Outer product of grids with an and-of-nands (`∧.⍲`) gets all overlaps.
