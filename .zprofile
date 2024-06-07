#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && fish
