LOCAL_HNAME=`who am i | sed -n 's/.*(\(.*\))/\1/p' | awk '{ n=split($0, a, "."); print a[n-1]}'`
PROMPT=$'%{$fg[red]%}($LOCAL_HNAME) %{$fg[yellow]%}%n$(git_prompt_info) %{$fg[green]%}%~ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
