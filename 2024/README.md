# AoC 2024

Done in APL.

Streamed on [Twitch](https://www.twitch.tv/pitrapen). Archived on [YouTube](https://www.youtube.com/playlist?list=PLUypSmvDdWt7mQJBGmkj4LE5Vu2_2g_kc).

## Day 19

Computes `c` - count of ways to design the patters using the specified towels (`T`) - using a simple DFS with memoization (`K` for sub-pattern, `V` for count). Part 1 is then trivial thanks to signum primitive.

## Day 20

Positions are kept in ravel order. Path (`p`) is computed using a simple recursive function. Create outer product matrices for hamiltonian distances (`d`) and picosecond savings (`s`). Construction of distances avoids using a simpler `∘.{+/|⍺-⍵}⍨⍸` (or even `+/¨|∘.-⍨⍸`) as it gives `WS FULL` error (due to a ~100 million tiny boxed arrays being create) and processes one axis at a time. Both matrices use ravel order of points on the path (hence the use of `⍋`). Then find combinations of distances and savings needed.

## Day 21

Use a single map with both pads, since buttons are unique (except `A` which becomes `a` in the directional pad). `step` returns best path from `⍺` to `⍵` using directional pad buttons. `run` will take a pattern and create instructions for the previous robot by prepending `a` or `A` to it since all robots start there, and 2-wise reduce that just calls `step`. Further, `run` will use lanternfish trick to keep a single copy and a count for repeating sequences.
