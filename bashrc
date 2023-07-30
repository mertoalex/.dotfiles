#!/usr/bin/env bash
export SHELL="bash"

function git_name() {
	onefetch &> /dev/null || return
	export name=`onefetch --no-art --no-color-palette --no-bold --no-title -c 7 -d description head pending created languages dependencies authors last-change contributors url commits churn lines-of-code size license | sed "s,\x1B\[[?0-9;]*[a-zA-Z],,g" | sed 's/.*: //g;s/ (.* branch)/ - /g' | sed -z 's/\n//g'` &> /dev/null
	[ -z "$name" ] || ([ "$color_prompt" "==" "yes" ] && echo "-(\[\033[1;33m\]${name}$1)") || echo "-(${name})"
}

[ -f ~/.color_mode ] || echo "unset color_prompt force_no_color_prompt" > ~/.color_mode
. ~/.color_mode # use colormode to change color!

if [ -z "$color_prompt" ] && [ "x$force_no_color_prompt" "!=" "xyes" ]; then
	case "$TERM" in
		xterm-kitty | xterm-color|*-256color) export color_prompt=yes;;
	esac

	# uncomment for a colored prompt, if the terminal has the capability; turned
	# off by default to not distract the user: the focus in a terminal window
	# should be on the output of commands, not on the prompt
	#force_color_prompt=yes

	if [ -n "$force_color_prompt" ]; then
		if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
			export color_prompt=yes
		else
			unset color_prompt
		fi
	fi
fi # copied from zshrc

export 	n="\[\033[0m\]"		#normal
export c1="\[\033[0;31m\]"	#kırmızı
export c2="\[\033[0;32m\]"	#yeşil
#export c3="\[\033[0;33m\]"	#sarı
export c4="\[\033[0;34m\]"	#mavi
export b1="\[\033[1;31m\]"	#bold kırmızı
#export b2="\[\033[1;32m\]"	#bold yeşil
#export b3="\[\033[1;33m\]"	#bold sarı
export b4="\[\033[1;34m\]"	#bold mavi
export	b="\[\033[1;37m\]"	#bold (beyaz/normal)

export icon=""
if [ "$UID" "==" "0" ]
then	export icon="💀"	
fi

function soru() { #Super-user OR (normal) User # bide bu 2simi diye **soru**ması müq xD
	[ "$UID" "==" "0" ] && echo "$2" || echo "$1"  
}


: 'geterr () {
	errstd=$?
	[ "$errstd" "!=" "0" ] && echo "$errstd $1" || true
}


getproc () {
	printf "";
}' #for future plan


if [ "x$color_prompt" "==" "xyes" ]
then	if [[ -n $SSH_CLIENT ]]; then
		PS1=$"$(soru ${c2} ${c4})┌────($(soru ${b4} ${b1})\u $icon \h$(soru ${c2} ${c4}))-[${b}\w$(soru ${c2} ${c4})]$(git_name $(soru ${c2} ${c4})) ${c1}(ssh)$(soru ${c2} ${c4})\n└─$(soru ${b4} ${b1})\$${n} "
		#PS1=$┌──(%n%m)-[%(6~.%-1~/…/%4~.%5~)] (ssh)$(git_name)\n└─$ '
		#RPROMPT=$'%(%? ⨯)%(%j ⚙)'
	else
		PS1=$"$(soru ${c2} ${c4})┌────($(soru ${b4} ${b1})\u $icon \h$(soru ${c2} ${c4}))-[${b}\w$(soru ${c2} ${c4})]$(git_name $(soru ${c2} ${c4}))\n└─$(soru ${b4} ${b1})\$${n} "
		#PS1=$'┌──(%n%m)-[%(6~.%-1~/…/%4~.%5~)]$(git_name)\n└─$ '
		#RPROMPT=$'%(%? ⨯)%(%j ⚙)'
	fi
else
	if [[ -n $SSH_CLIENT ]]; then
		PS1=$'┌────(\u $icon \h)-[\w]$(git_name) (ssh)\n└─\$ '
		#PS1=$┌──(%n%m)-[%(6~.%-1~/…/%4~.%5~)] (ssh)$(git_name)\n└─$ '
		#RPROMPT=$'%(%? ⨯)%(%j ⚙)'
	else
		PS1=$'┌────(\u $icon \h)-[\w]$(git_name)\n└─\$ '
		#PS1=$'┌──(%n%m)-[%(6~.%-1~/…/%4~.%5~)]$(git_name)\n└─$ '
		#RPROMPT=$'%(%? ⨯)%(%j ⚙)'
	fi
fi


[ -f ~/.env			] && source ~/.env

#start xorg on startup, by JohnHammond on github. (so much edited)
if [ "x$XDG_VTNR" "==" "x1" ]; then
	if [ $(tty | grep tty) ]; then
		export MOZ_ENABLE_WAYLAND=1
		rm -rvf .river-logs/*
		river
	fi
fi