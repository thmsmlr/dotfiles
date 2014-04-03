### ALIASES ###
alias c='cd'
alias cs='cd'
alias cd..='cd ..'
alias ..='cd ..'
alias so='source ~/.bash_profile'
alias ll='ls -la'

### Rails stuff ###
alias rs='rails server'

### Git Stuff ###
alias gs='git status'
alias gcb='git checkout -b'

safesource() {
  [[ -s $1 ]] && source $1
}

safesource /usr/local/etc/bash_completion.d/git-completion.bash
safesource /usr/local/etc/bash_completion.d/git-prompt.sh
safesource ~/.bash_profile.local
safesource "$HOME/.rvm/scripts/rvm"

git() {
  case "$@" in
    "rm .")
      command git rm $(git ls-files --deleted)
      ;;
    "branch old")
      for k in $(git branch --merged | grep -v "\->" | sed -e "/^\*.*$/d" | sed s/^..//); do
        echo -e $(git log -1 --pretty=format:"%Cgreen%ci %Cred%cr%Creset" "$k")\\t"$k"
      done | sort
      ;;
    "branch clean old")
      for k in $(git branch --merged | grep -v "\->" | sed -e "/^\*.*$/d" | sed s/^..//); do
        git branch -d ${k}
      done 
      ;;
    "diff"*)
      command git "$@" --color
      ;;
    *)
      command git "$@"
      ;;
  esac
}

### Ruby Stuff
gem() {
  case "$@" in
    "install"*)
      command gem "$@" --no-rdoc --no-ri
      ;;
    *)
      command gem "$@"
      ;;
  esac
}


##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~ 
# The last pwdmaxlen characters of the PWD are displayed 
# Leading partial directory names are striped off 
#
# /home/me/stuff 
# -> 
# ~/stuff if USER=me /usr/share/big_dir_name 
# -> 
# ../share/big_dir_name if pwdmaxlen=20
##################################################



bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=35
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {
    case $TERM in
     xterm*|rxvt*)
         local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
          ;;
     *)
         local TITLEBAR=""
          ;;
    esac
    local NONE="\[\033[0m\]" # unsets color to term's fg color
    
    # regular colors
    local K="\[\033[0;30m\]" # black
    local R="\[\033[0;31m\]" # red
    local G="\[\033[0;32m\]" # green
    local Y="\[\033[0;33m\]" # yellow
    local B="\[\033[0;34m\]" # blue
    local M="\[\033[0;35m\]" # magenta
    local C="\[\033[0;36m\]" # cyan
    local W="\[\033[0;37m\]" # white
    
    local UC=$W # user's color
    [ $UID -eq "0" ] && UC=$R # root's color
    
    local HNAME=`who am i | sed -n 's/.*(\(.*\))/\1/p' | awk '{ n=split($0, a, "."); print a[n-1]}'`
    PS1=""
    if [ ! -z "$HNAME" ]; then
      PS1="${R}(${HNAME}) "
    fi

    if type __git_ps1 > /dev/null 2>&1; then
      PS1="${PS1}${Y}\u${C}\$(__git_ps1) ${G}\${NEW_PWD} ${NONE}"
    else
      PS1="${PS1}${Y}\u ${G}\${NEW_PWD} ${NONE}"    
    fi
    # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ " extra backslash in front of \$ to make bash colorize the prompt
}

### STARTUP ####

PROMPT_COMMAND=bash_prompt_command 
bash_prompt 
unset bash_prompt

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/ruby/2.0.0-p247/bin:~/.bin/:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Added npm to path
export PATH="/usr/local/share/npm/bin:$PATH"

