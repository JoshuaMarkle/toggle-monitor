#!/bin/sh
intern=eDP-1
extern=HDMI-1

# Ensure xrandr is available
if ! command -v xrandr &>/dev/null; then
	notify-send -u normal "Error: xrandr is not installed." >&2
  exit 1
fi

monitor_connected=$(xrandr | grep "$extern disconnected")

# Check connection (external monitor takes priority)
if ! [[ -z "$monitor_connected" ]]; then
	# Update monitor
	xrandr --output "$intern" --auto --output "$extern" --off
	notify-send -u normal "Monitor" "Defaulted to internal monitor"

	# Change alacritty font size to 10
	sed -i "s/  size: 12/  size: 10/" "$HOME/.config/alacritty/alacritty.yml"
else
	# Update monitor
  xrandr --output "$intern" --off --output "$extern" --auto
	notify-send -u normal "Monitor" "Using active external monitor"

	# Change alacritty font size to 12
	sed -i "s/  size: 10/  size: 12/" "$HOME/.config/alacritty/alacritty.yml"
fi

# Reload picom and polybar and awesome
pkill polybar
pkill picom
awesome-client "awesome.restart()"
