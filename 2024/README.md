# AoC 2024

Done in APL.

Streamed on [Twitch](https://www.twitch.tv/pitrapen). Archived on [YouTube](https://www.youtube.com/playlist?list=PLUypSmvDdWt7mQJBGmkj4LE5Vu2_2g_kc).

## Day 20

Positions are kept in ravel order. Figure out path (`p`) using a simple recursive function. Create outer product matrices for hamiltonian distances (`d`) and picosecond savings (`s`). Construction of distances avoids using a simpler `∘.{+/|⍺-⍵}⍨⍸` (or even `+/¨|∘.-⍨⍸`) as it gives `WS FULL` error (due to a ~100 million tiny boxed arrays being create) and processes one axis at a time. Both matrices use ravel order of points on the path (hence use of `⍋`).