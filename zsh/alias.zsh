# エイリアス
unamestr=$(uname)
if [[ "$unamestr" == "Linux" ]]; then platform="linux"; fi
if [[ "$unamestr" == "Darwin" ]]; then platform="mac"; fi

if [[ $platform == "linux" ]]; then
  alias open="xdg-open"
  # Open Current Directory
  alias ii="xdg-open ."
elif [[ $platform == "mac" ]]; then
  # eagle
  alias eagle='/Applications/EAGLE-*/EAGLE.app/Contents/MacOS/EAGLE'
fi

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias cdb='cd -'
alias reload='exec zsh -l'

# for ocaml
alias ocaml='rlwrap ocaml'

# for scheme
alias scheme='rlwrap scheme'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# g++
alias g++='g++ -std=c++17 -Wall'

# text editor
alias vv='nvim'
alias ss='subl'
alias vim='nvim'
alias vi='nvim'

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
  # Mac
  alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
  # Linux
  alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
  # Cygwin
  alias -g C='| putclip'
fi

alias ...="../../"
alias ....="../../../"
alias .....="../../../../"
