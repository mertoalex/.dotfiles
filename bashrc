export SHELL="bash"

#nvim() {
#	pkill picom
#	/bin/nvim $*
#	picom &
#}

if [[ -n $SSH_CLIENT ]]; then
  PS1="\u@\h:\w \[\e[0;32m\](ssh)\[\e[0m\]\n\$ "
else
  PS1="\u@\h:\w\n\$ "
fi

[ -f ~/.fzf.bash	] && source ~/.fzf.bash
[ -f ~/.aliases		] && source ~/.aliases
[ -f ~/.definitions	] && source ~/.definitions
