#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias c='tput clear'
PS1='> ' # main prompt

PATH=$PATH:$HOME/.local/bin

#eval "$(starship init bash)"
