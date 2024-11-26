Steam_ambient_music is a simple shell script that provides console-like (e.g. Playstation) ambient music to Steam for Linux. Best combined with Steam Big Picture. In other words when Steam window gets in focus ambient music start playing. And when it loses focus of game started music stop playing.

## Installation

Steam_ambient_music doesn't need any installation. Just copy this script somewhere on your PC and start it.
This script was tested on desktop Archlinux with GNOME on Wayland (it uses GNOME shell extension that provides info about window in focus).

#### Dependencies

- MPV or other music player of your choice.
- Installed and activated gnome shell extension Window Calls Extended by [hseliger](https://extensions.gnome.org/accounts/profile/hseliger). You can get it on [GNOME Extensions](https://extensions.gnome.org/extension/4974/window-calls-extended/).
- Ambient music (i started using this script with Playstation 4 menu music and then found great collection on YouTube).

#### Configuration

Before using you must change three variables at the beginning of this script. By default it uses great [mpv](https://mpv.io) with some options.

```sh
PLAYER_BIN="$(which mpv)"
PLAYER_OPTS="--really-quiet --no-video --volume=65 --loop --save-position-on-quit"
MUSIC_FILE="/home/gen1s/Games/ambient/Ambinet_Alpha_Waves_Heal_Body_Damage.mp3"
```

## Contributing

The easiest ways to contribute is by starring the repository and opening GitHub issues for features you'd like to see.

Code contributions are also very welcome.

## Troubleshooting

Any errors get logged directly into the console and should indicate what went wrong.

If you encounter an error that hasn't been reported yet, don't be afraid to open a new issue.

## Disclaimer

Steam_ambient_music is not affiliated, associated, authorized, endorsed by, or in any way officially connected with Valve Corporation.

All product and company names are trademarks™ or registered® trademarks of their respective holders. Use of them does not imply any affiliation with or endorsement by them.