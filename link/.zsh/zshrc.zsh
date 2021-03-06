autoload -Uz colors && colors
bindkey -e # emacs style key bindings
local WORDCHARS=${WORDCHARS//\//}
setopt CORRECT

setopt ALL_EXPORT

EDITOR=vim
PAGER="less"
SHELL="/bin/zsh"

GREP_COLOR='3;33'

unsetopt ALL_EXPORT

# Load nested configs
for f in $(find -L $HOME/.zsh/ -name \*.zsh  | grep -v zshrc.zsh); do
  . $f
done

if which stty > /dev/null; then
  stty -ixon
fi

command -v gdircolors >/dev/null 2>&1 && eval $( gdircolors -b $HOME/.zsh/LS_COLORS)
command -v  dircolors >/dev/null 2>&1 && eval $( dircolors -b $HOME/.zsh/LS_COLORS)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fpath=(~/.zsh/completion ~/.zsh/zsh-completions/src $fpath)
