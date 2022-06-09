# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# zsh-autocomplete from marlonrichert
## source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# For a better Prompt
precmd() { print "" }
PS1='%B%(?.%K{73}.%K{167}) %k %F{195}%4~ / %k%b%f '
PS2='%K{167} %K{235} -> %k '
#RPROMPT='%K{234} %K{235} %F{230}%D{%H:%M} %K{167} %k'

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
#
# End of lines added by compinstall
#
PATH=$PATH:$HOME/.local/bin
#eval "$(starship init zsh)"
