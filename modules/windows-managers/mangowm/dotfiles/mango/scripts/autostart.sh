#!/bin/bash

set +e

# dbus environment for Wayland
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1

# xdg desktop portal for wlroots
systemctl --user start xdg-desktop-portal-wlr.service >/dev/null 2>&1 &

# quickshell
qs -c noctalia-shell &

# keyboard input method
fcitx5 -d

# auto display
$HOME/.config/mango/scripts/auto-display.sh &
