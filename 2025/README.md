# AoC 2025

Done in APL.

See parent [README.md](../README.md) for setup.

| Day | Time (ms) |
| --- | --------- |
| 1   |      54.1 |
| 2   |    3981.6 |
| 3   |      34.2 |
| 4   |      45.7 |
| 5   |      37.5 |
| 6   |      47.3 |
| 7   |      34.8 |
| 8   |      99.6 |
| 9   |     111.8 |
| 10  |       N/A |
| 11  |       N/A |
| 12  |       N/A |

Note: includes interpreter start time.

## Day 1

Both parts done the same way, except part 2 breaks up rotations into 1 click moves.

## Day 2

Regex...

## Day 3

Dynamic programming using max scan.

## Day 4

Simple stencil solution.

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
