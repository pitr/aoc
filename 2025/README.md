# AoC 2025

Done in APL.

See parent [README.md](../README.md) for setup.

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

Run union-find until parent vector has a single common root.

## Day 9

Part 1 is a trivial outer product. For part 2, rectangles that have inner tiles are excluded. Code is heavily optimized by working on one axis at a time.
