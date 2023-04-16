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

setxkbmap -model pc105 -layout us,ru -option grp:caps_toggle &
xsetroot -cursor_name left_ptr &
wmname LG3D
numlockx on &
picom --config $HOME/.config/picom.conf &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
dunst &
#slstatus &
dwmblocks &
exec dwm
