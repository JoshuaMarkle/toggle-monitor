# toggle-monitor
A small script to handle monitor switching on arch linux

## What happens
1. If an external monitor is detected, set that as the primary screen. If not, use the original (builtin) screen
2. Ajust alacritty font
3. Reload awesome after killing polybar and picom

This effectively reloads everything I need and correctly sizing for my larger monitor.
