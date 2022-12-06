# AoC in APL

## Setup

Coded in Sublime Text. [Sublime APL](https://github.com/StoneCypher/sublime-apl) package used.

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

Note: replace with your own PATH, `~/` for home directory doesn't work.

```
{
    "cancel": { "kill": true },
	"cmd": [
		"/usr/local/bin/dyalogscript",
		"ConfigFile=/PATH/TO/.dyalog/dyalog.dcfg",
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
