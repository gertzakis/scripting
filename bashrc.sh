# Git Branch 
git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Prompt
get_prompt()
{
	# Colors
	local BLACK='\[\033[0;30m\]'
	local BLUE='\[\033[0;34m\]'
	local GREEN='\[\033[0;32m\]'
	local CYAN='\[\033[0;36m\]'
	local RED='\[\033[0;31m\]'
	local PURPLE='\[\033[0;35m\]'
	local BROWN='\[\033[0;33m\]'
	local LGREY='\[\033[0;37m\]'
	local DGREY='\[\033[1;30m\]'
	local LBLUE='\[\033[1;34m\]'
	local LGREEN='\[\033[1;32m\]'
	local LCYAN='\[\033[1;36m\]'
	local LRED='\[\033[1;31m\]'
	local LPURPLE='\[\033[1;35m\]'
	local YELLOW='\[\033[1;33m\]'
	local WHITE='\[\033[1;37m\]'
	
	local USER="${LRED}┌─[ ${LBLUE}\u${LRED}@${LBLUE}\h ${LRED}]"
	local DIR="${GREEN}\w${YELLOW}\$(git_branch)\${GREEN}"
	local PROMPT="${LRED}└─$ ${WHITE}"

	PS1="\n${USER} ${DIR}\n${PROMPT}"
}

# Some aliases
alias gl='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn %ai]" --decorate --graph'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn %ai] %n%b" --decorate --graph --numstat'

# git variables for showing changes, when you use __git_ps1
export GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWCOLORHINTS=1 GIT_PS1_DESCRIBE_STYLE="branch" GIT_PS1_SHOWUPSTREAM="auto git"

get_prompt
