#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#autostart=""

#for program in $autostart; do
#	pidof -s "$program" || "$program" &
#done > /dev/null 2>&1

#setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle &
xsetroot -cursor_name left_ptr &
wmname LG3D
numlockx on &
picom --config $HOME/.config/picom.conf &
#xcompmgr &
# pipewire &
# pipewire-pulse &
# wireplumber &
#xbindkeys &
#xwallpaper --zoom ".config/bg.jpg" &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# mpd &
#dunst &
#variety &
#$HOME/.config/dwm-bar/dwm_bar.sh &
#slstatus &
flameshot &
pcmanfm -d &
xbindkeys &
#lxpolkit &
#exec dwm
#nm-applet &
eww daemon &
eww open-many time stats todo github vpn &
exec awesome
#exec qtile start
