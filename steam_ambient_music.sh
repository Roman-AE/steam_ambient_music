#!/bin/sh

#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    steam_ambient_music.sh
#%
#% DESCRIPTION
#%    This is a shell script to add console-like (eg. Playstation) ambient music to Steam. Best combined with Steam Big Picture.
#%
#================================================================
#- IMPLEMENTATION
#-    version         steam_ambient_music 1.0.0
#-    author          Roman "gen1s" Aysin
#-    copyright       Copyright (c) Roman Aysin
#-    license         GNU General Public License
#-
#================================================================
#  HISTORY
#     2024/11/26 : gen1s : Script creation
#
#================================================================
# END_OF_HEADER
#================================================================

PLAYER_BIN="$(which mpv)"
PLAYER_OPTS="--really-quiet --no-video --volume=65 --loop --save-position-on-quit"
MUSIC_FILE="/home/gen1s/Games/ambient/Ambinet_Alpha_Waves_Heal_Body_Damage.mp3"

check_depends() {
	# check if player binary is exist and executable
	if [ -f "$PLAYER_BIN" ]; then
		if [ ! -x "$PLAYER_BIN" ]; then
			echo >&2 "$PLAYER_BIN is not executable"
			exit 2
		fi
	else
		echo >&2 "$PLAYER_BIN is not found"
		exit 2
	fi

	# check if music file is available
	if [ ! -f "$MUSIC_FILE" ]; then
		echo >&2 "$MUSIC_FILE is not found"
		exit 2
	fi

	# check if gnome-shell extension "Window Calls Extended" is installed and working
	if [ $(gnome-extensions list --active 2>/dev/null | grep window-calls-extended@hseliger.eu | wc -l) -le 0 ]; then
		echo >&2 "Gnome shell extension \"Window Calls Extended\" is not installed or not enabled"
		exit 2
	fi

	return 0
}

check_window() {
	local activeWindow="$(gdbus call --session \
		--dest org.gnome.Shell \
		--object-path /org/gnome/Shell/Extensions/WindowsExt \
		--method org.gnome.Shell.Extensions.WindowsExt.FocusClass)"
	activeWindow=$(echo "$activeWindow" | sed "s/^('//;s/',)$//")
	[ "steam" = "$activeWindow" ] && return 0 || return 1
}

check_depends

PID=-1
while true; do
	if check_window; then
		if [ $PID -eq -1 ]; then
			$PLAYER_BIN $PLAYER_OPTS "$MUSIC_FILE" &
			PID=$!
			echo "$PLAYER_BIN started with PID $PID"
		fi
	else
		if [ $PID -gt -1 ]; then
			ps -p $PID >/dev/null && kill -15 $PID
			echo "Killed process with PID $PID"
			PID=-1
		fi
	fi

	sleep 1
done
