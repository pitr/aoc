# Advent of Code

My solutions to Advent of Code. Some solutions were either livestreamed or explained on [YouTube](https://www.youtube.com/@arrayaccessor/playlists).

- 2015 - APL complete (missing 4 as it requires MD5)
- 2016 - APL complete (missing 5, 14, 17 as they require MD5)
- 2017 - APL complete
- 2018 - APL complete
- 2019 - Ruby complete, APL ongoing
- 2020 - Mix of J/Ruby/APL, complete
- 2021 - APL complete
- 2022 - APL complete, some K
- 2023 - APL complete
- 2024 - APL complete
- 2025 - APL complete

Also, https://everybody.codes is under the corresponding folder.

- 2024 - APL in progress

## APL setup

`⎕IO` is always assumed to be 0. Solutions developed iteratively in Sublime Text, using the Build system (see [demo here](https://www.youtube.com/watch?v=6Z7o6pRonoY)).

Requirements:

- [Dyalog APL](https://www.dyalog.com/)
- [Sublime Text](https://www.sublimetext.com/)
- [APL package for Sublime Text](https://github.com/StoneCypher/sublime-apl)

### `~/.dyalog/dyalog.dcfg`

```
{ settings: {
	Default_IO: 0,
	Default_PP: 15,
	Default_PW: 32767,
	Dyalog_LineEditor_Mode: 1,
	MAXWS: "4G",
	Log_Size: "2M",
}}
```

### `APL.sublime-build`

Custom build system that relies on dyalogscript.

Note: replace with your own /PATH/HOME, `~/` for home directory doesn't work.

```
{
    "cancel": { "kill": true },
	"cmd": [
		"/usr/local/bin/dyalogscript",
		"ConfigFile=/PATH/HOME/.dyalog/dyalog.dcfg",
		"$file"
	],
	"selector": "source.apl"
}
```

### `APL.sublime-settings`

```
{
	"auto_complete": false,
	"caret_style": "solid",
	"draw_indent_guides": false,
	"ensure_newline_at_eof_on_save": true,
	"fold_buttons": false,
	"font_face": "APL386 Unicode",
	"font_size": 22,
	"line_numbers": false,
	"translate_tabs_to_spaces": true
}
```
