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

get_prompt
