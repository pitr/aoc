# AoC 2025

Done in APL.

See parent [README.md](../README.md) for setup.

| Day | Time (ms) |
| --- | --------- |
| 1   |      44.1 |
| 2   |      40.3 |
| 3   |      34.2 |
| 4   |      45.7 |
| 5   |      37.5 |
| 6   |      47.2 |
| 7   |      34.8 |
| 8   |      99.6 |
| 9   |     111.5 |
| 10  |    1284.0 |
| 11  |     221.4 |
| 12  |      48.3 |

Note: includes interpreter start time.

## Day 1

Both parts done the same way, except part 2 breaks up rotations into 1 click moves.

## Day 2

Checks each range against possible ways to repeat (e.g. 2 6 means all 2-digit numbers repeated to make a 6 digit number). Part 2 needs to correct for double counting single digit numbers repeated few different ways.

Originally solved with regex.

## Day 3

Dynamic programming using max scan.

## Day 4

Simple 3-wise reductions. Faster than stencil.

## Day 5

Fix ranges using max scan. Part 1 is then trivial with ⍸ (interval index). Part 2 is similarly trivial - alternating sum.

## Day 6

Convert input to strings like `×/123 45 6` and evaluate.

## Day 7

Compute part 2 using cumulative traversal, where last column is the number of timelines per position. Part 1 is then simply counting timeline splits.

## Day 8

Part 1 uses transitive closure (`∨.∧⍨⍣≡`) to find all connected circuits. Part 2 is about finding the furthest junction box and its closest neighbour.

Previous implementation used union-find with recusion, but the iterative approach was significantly slower. Another improvement was processing one axis at a time.

## Day 9

Part 1 is a trivial outer product. For part 2, rectangles that have inner tiles are excluded. Code is heavily optimized by working on one axis at a time.

## Day 10

Pre-compute power set for each button combination. Part 1 finds all matches (`∧.=`) in a dot product of combinations and buttons. Part 2 implements the odd/even recursive solution described in [this post](https://old.reddit.com/r/adventofcode/comments/1pk87hl). This recursive function is memoized.

Originally, part 1 was BFS on button presses and part 2 used [SciPy](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.linprog.html).

## Day 11

`paths` uses fixpoint of dot product over adjacency matrix to find paths. Part 2 is a product of subpaths.

## Day 12

Just checks if regions are large enough for all units of presents.
