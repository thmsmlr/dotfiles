set -gx PATH /usr/bin/ $PATH
set -gx theme_color_scheme base16
set -gx LC_ALL en_US.utf8
set -gx LANG en_US.utf8

set -gx PYENV_ROOT /stitchfix/z-pyenv/pyenv
set -gx PATH $PYENV_ROOT/bin $PATH

set -gx STITCHFIX_USER_EMAIL tmillar@stitchfix.com


function activate
  source $PYENV_ROOT/versions/$argv/bin/activate.fish
end
