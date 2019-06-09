set -gx PATH /usr/bin/ $PATH
set -gx PATH /usr/local/bin/ $PATH
set -gx theme_color_scheme base16
set -gx LC_ALL en_US.utf8
set -gx LANG en_US.utf8

set -gx PYENV_ROOT /stitchfix/z-pyenv/pyenv
set -gx PATH $PYENV_ROOT/bin $PATH

set -gx STITCHFIX_USER_EMAIL tmillar@stitchfix.com
set -gx AWS_DEFAULT_REGION us-east-1


function activate
  source $PYENV_ROOT/versions/$argv/bin/activate.fish
end

function sfclone
  git clone git@github.com:stitchfix/$argv.git
end

function igor-publish
  /root/code/igor-publish/command $argv
end
