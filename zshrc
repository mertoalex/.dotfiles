#!/usr/bin/env zsh
# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# kali theme for zsh 
# I found it in web -mertoalex

export SHELL="zsh"

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
#setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
#setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
#bindkey '^[[5~' beginning-of-buffer-or-history    # page up
#bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

# History configurations
HISTFILE=~/.zsh_history
#HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot || echo '')
fi

#you can make this if you want to make config file:

#uncomment this and
# . ~/.color_mode # <<< export no_color="no"

#change these lines
# ~/.definitions:
# 33: [ "$mode" "==" "1" ] && echo 'no_color=""'	> ~/.color_mode
# 34: [ "$mode" "==" "0" ] && echo 'no_color="yes"'	> ~/.color_mode

[ -f ~/.color_mode ] || echo "unset color_prompt force_no_color_prompt" > ~/.color_mode
. ~/.color_mode # use colormode to change color!

if [ -z "$color_prompt" ] && [ "x$force_no_color_prompt" "!=" "xyes" ]; then
	# set a fancy prompt (non-color, unless we know we "want" color)
	case "$TERM" in
		xterm-kitty|xterm-color|*-256color) export color_prompt=yes;;
	esac

	# uncomment for a colored prompt, if the terminal has the capability; turned
	# off by default to not distract the user: the focus in a terminal window
	# should be on the output of commands, not on the prompt
	#force_color_prompt=yes

	if [ -n "$force_color_prompt" ]; then
		if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
			# We have color support; assume it's compliant with Ecma-48
			# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
			# a case would tend to support setf rather than setaf.)
			export color_prompt=yes
		else
			unset color_prompt
		fi
	fi
fi

function git_name() {
	onefetch &> /dev/null || return
	export name=`onefetch --no-art --no-color-palette --no-bold --no-title -c 7 -d description head pending created languages dependencies authors last-change contributors url commits churn lines-of-code size license | sed "s,\x1B\[[?0-9;]*[a-zA-Z],,g" | sed 's/.*: //g;s/ (.* branch)/ - /g' | sed -z 's/\n//g'` &> /dev/null
	[ -z "$name" ] || [ "$1" "==" "yes" ] && echo "-(%B%F{yellow}${name}$2)" || echo "-(${name})"
}

#source ~/.git-prompt.sh # https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
#somehow I broked git thing in devuan :/
#update: I Fixed it, Yea Dude!


if [ "x$color_prompt" "==" "xyes" ]; then
	if [[ -n $SSH_CLIENT ]]; then
		PROMPT=$'%F{%(#.blue.green)}┌────(%B%F{%(#.red.blue)}%n %(#.💀.) %m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]$(git_name yes "%b%F{%(#.blue.green)}") %b%F{red}(ssh)%b%F{%(#.blue.green)}\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
		RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
	else
		PROMPT=$'%F{%(#.blue.green)}┌────(%B%F{%(#.red.blue)}%n %(#.💀.) %m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]$(git_name yes "%b%F{%(#.blue.green)}")\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
		RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
	fi

	# enable syntax-highlighting
	if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
		. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
		ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern); ZSH_HIGHLIGHT_STYLES[default]=none; ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold; ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold; ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline; ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta; ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline; ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold; ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline; ZSH_HIGHLIGHT_STYLES[path]=underline; ZSH_HIGHLIGHT_STYLES[path_pathseparator]=; ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=; ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold; ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold; ZSH_HIGHLIGHT_STYLES[command-substitution]=none; ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta; ZSH_HIGHLIGHT_STYLES[process-substitution]=none; ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta; ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta; ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta; ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none; ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold; ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow; ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow; ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow; ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta; ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta; ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta; ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta; ZSH_HIGHLIGHT_STYLES[assign]=none; ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold; ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold; ZSH_HIGHLIGHT_STYLES[named-fd]=none; ZSH_HIGHLIGHT_STYLES[numeric-fd]=none; ZSH_HIGHLIGHT_STYLES[arg0]=fg=green; ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold; ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold; ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold; ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold; ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold; ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold; ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
	fi	# a little less lines eaten by this now!
else
	if [[ -n $SSH_CLIENT ]]; then
		PROMPT=$'┌────(%n  %m)-[%(6~.%-1~/…/%4~.%5~)]$(git_name) (ssh)\n└─$ '
		RPROMPT=$'%(%? ⨯)%(%j ⚙)'
	else
		PROMPT=$'┌────(%n  %m)-[%(6~.%-1~/…/%4~.%5~)]$(git_name)\n└─$ '
		RPROMPT=$'%(%? ⨯)%(%j ⚙)'
	fi
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a'
	;;
*)
	;;
esac

new_line_before_prompt=yes
precmd() {
	# Print the previously configured title
	print -Pnr -- "$TERM_TITLE"

	# Print a new line before the prompt, but only if it is not the first line
	if [ "$new_line_before_prompt" = yes ]; then
		if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
			_NEW_LINE_BEFORE_PROMPT=1
		else
			print ""
		fi
	fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias diff='diff --color=auto'
	alias ip='ip --color=auto'

	export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
	export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
	export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
	export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
	export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
	export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
	export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

	# Take advantage of $LS_COLORS for completion as well
	zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
	. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	# change suggestion color
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

[ -f ~/.fzf.zsh		] && source ~/.fzf.zsh
[ -f ~/.aliases		] && source ~/.aliases
[ -f ~/.definitions	] && source ~/.definitions
[ -f ~/.cargo/env	] && source ~/.cargo/env
[ -f ~/.env			] && source ~/.env
[ -f /etc/profile.d/dotnet.sh	] && source /etc/profile.d/dotnet.sh
[ -d /.fonts ] && for file in $(ls ~/.fonts/*.sh);do [ -d "$file" ] && source "$file";done

[ -f "~/Pictures/I can't live with modern tech anymore.png" ] && [ "x$TERM" == "xxterm-kitty" ] && uwufetch -i "~/Pictures/I\ can\'t\ live\ with\ modern\ tech\ anymore.png"

#start xorg on startup, by JohnHammond on github. (so much edited)
if [ $XDG_VTNR -eq 1 ]; then
	if [ $(tty | grep tty) ]; then
		export MOZ_ENABLE_WAYLAND=1
		rm -rvf .river-logs/*
		river
	fi
fi
