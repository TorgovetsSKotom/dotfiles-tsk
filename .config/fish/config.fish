# TokyoNight Color Palette
set -l foreground c0caf5
set -l background 1a1b26
set -l selection 33467c
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# # Syntax Highlighting Colors
# set -U fish_color_normal $foreground
# set -U fish_color_command $cyan
# set -U fish_color_keyword $pink
# set -U fish_color_quote $yellow
# set -U fish_color_redirection $foreground
# set -U fish_color_end $orange
# set -U fish_color_error $red
# set -U fish_color_param $purple
# set -U fish_color_comment $comment
# set -U fish_color_selection --background=$selection
# set -U fish_color_search_match --background=$selection
# set -U fish_color_operator $green
# set -U fish_color_escape $pink
# set -U fish_color_autosuggestion $comment
# 
# # Completion Pager Colors
# set -U fish_pager_color_progress $comment
# set -U fish_pager_color_prefix $cyan
# set -U fish_pager_color_completion $foreground
# set -U fish_pager_color_description $comment
# set -U fish_pager_color_selected_background --background=$selection

# Background
#_tokyonight_set_background $foreground $background

# set -Ux TOKYONIGHT night

eval "$(zoxide init fish)"
alias cd='z'
alias ls='lsd -la --group-directories-first'
# alias ls='ls -la'
alias find='fd'
alias cat='bat'
alias du='dust'
alias df='duf'
alias tree='broot'
alias grep='grep --color=auto'
alias update='sudo pacman -Sy && sudo powerpill -Su && paru -Su'
alias config='/usr/bin/git --git-dir=/home/tsk/.cfg/ --work-tree=/home/tsk'
alias feh='feh -.'
alias broot='broot --no-tree --sort-by-type-dirs-first -h'
alias c='clear'

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# thefuck --alias | source
