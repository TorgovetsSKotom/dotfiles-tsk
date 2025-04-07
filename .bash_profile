#
# ~/.bash_profile
#

source /home/tsk/.config/broot/launcher/bash/br

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

