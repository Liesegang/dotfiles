#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/etc/lib/vital.sh

if is_linux && [! -e $HOME/.anyenv ]; then
  git clone https://github.com/anyenv/anyenv ~/.anyenv
fi

if has "git"; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"

  if ! [ -d "$(anyenv root)/plugins/anyenv-update" ]; then
    mkdir -p $(anyenv root)/plugins
    git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
    log_pass "anyenv-update: install successfully"
  else
    log_pass "anyenv-update: already installed"
  fi
else
    log_fail "error: require: git"
    exit 1
fi

if ! [ -d "$HOME/.config/anyenv/anyenv-install" ]; then
  anyenv install --force-init
fi

anyenv install pyenv -s && log_pass "pyenv: install successfully"
anyenv install rbenv -s && log_pass "rbenv: install successfully"
anyenv install nodenv -s && log_pass "nodenv: install successfully"

if ! [ -d "$(pyenv root)"/plugins/xxenv-latest ]; then
  git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest
fi

if ! [ -d "$(rbenv root)"/plugins/xxenv-latest ]; then
  git clone https://github.com/momo-lab/xxenv-latest.git "$(rbenv root)"/plugins/xxenv-latest
fi

if ! [ -d "$(nodenv root)"/plugins/xxenv-latest ]; then
  git clone https://github.com/momo-lab/xxenv-latest.git "$(nodenv root)"/plugins/xxenv-latest
fi

source $HOME/.zshenv

pyenv latest install -s && log_pass "python3: install successfully"
pyenv latest install 2 -s && log_pass "python2: install successfully"
pyenv global $(pyenv latest --print 3) $(pyenv latest --print 2)
pyenv rehash

rbenv latest install -s && log_pass "ruby: install successfully"
rbenv latest global
rbenv rehash

nodenv latest install -s && log_pass "nodnev: install successfully"
nodenv latest global
nodenv rehash

sudo tlmgr update --self --all
sudo tlmgr paper a4
