# Advent of Code

My solutions to Advent of Code.

- 2015 - APL, partial
- 2016 - APL, complete
- 2018 - APL, complete
- 2019 - Ruby, complete
- 2020 - J and/or Ruby, complete
- 2021 - APL, complete
- 2022 - APL, in progress

## APL setup

`⎕IO` is always assumed to be 0. Solutions developed iteratively in Sublime Text, using the Build system.

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
