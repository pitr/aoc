# AoC in APL

## Setup

### IDE

```
]cd code/aoc/2021
]boxing on -style=mid -trains=parens -fns=on
```

### `~/.dyalog/dyalog.dcfg`

```
{ settings: {
	Default_IO: 0,
	Default_PP: 15,
	Dyalog_LineEditor_Mode: 1,
	MAXWS: "4G",
	Log_Size: "2M",
}}
```

### `APL.sublime-build`

```
{
    "cancel": { "kill": true },
	"cmd": [
		"/Applications/Dyalog-18.0.app/Contents/Resources/Dyalog/dyalog",
		"-script",
		"$file",
		"ConfigFile=/PATH/TO/.dyalog/dyalog.dcfg"
	],
	"selector": "source.apl"
}
```

### `APL.sublime-settings`

```
{
	"font_face": "APL386 Unicode",
	"font_size": 22,
	"translate_tabs_to_spaces": true,
	"ensure_newline_at_eof_on_save": true
}
```
