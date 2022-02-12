#!/usr/bin/env sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
export GDK_BACKEND=wayland
export CLUTTER_BACKENT=wayland
export QT_STYLE_OVERRIDE=kvantum
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=sway
exec dbus-run-session /sbin/sway
