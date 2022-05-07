# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

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
