#!/usr/bin/env bash

# This was copied verbatim from a awesome discussion at https://github.com/hyprwm/Hyprland/discussions/3098
# This script updates all the needed tmux vars AND updates dbus environment also
set -e

[[ -n $HYPRLAND_DEBUG_CONF ]] && exit 0

_envs=(
	WAYLAND_DISPLAY
	DISPLAY
	XCURSOR_SIZE
	USERNAME
	XDG_BACKEND
	XDG_CURRENT_DESKTOP
	XDG_SESSION_TYPE
	XDG_SESSION_ID
	XDG_SESSION_CLASS
	XDG_SESSION_DESKTOP
	XDG_SEAT
	XDG_VTNR
	# sway
	SWAYSOCK
	# hyprland
	HYPRLAND_CMD
	HYPRLAND_INSTANCE_SIGNATURE
	# toolkit
	_JAVA_AWT_WM_NONREPARENTING
	QT_QPA_PLATFORM
	QT_WAYLAND_DISABLE_WINDOWDECORATION
	GRIM_DEFAULT_DIR
	# ssh
	SSH_AUTH_SOCK
)

for v in "${_envs[@]}"; do
	if [[ -n ${!v} ]]; then
		tmux setenv -g "$v" "${!v}"
	fi
done

dbus-update-activation-environment --systemd "${_envs[@]}"
