#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/etc/lib/vital.sh

if has "git"; then
  if ! [ -d "$HOME/.anyenv" ]; then
    git clone https://github.com/riywo/anyenv ~/.anyenv
    export PATH="$HOME/.anyenv/bin:$PATH"
    anyenv install --init
    log_pass "anyenv: install successfully"
  else
    log_pass "anyenv: already installed"
  fi

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

anyenv install pyenv -s && log_pass "pyenv: install successfully"
anyenv install rbenv -s && log_pass "rbenv: install successfully"

eval "$(anyenv init -)"

PYTHON3_VER=$(pyenv install -l | grep -E "  3.[^-]*$" | tail -1)
PYTHON2_VER=$(pyenv install -l | grep -E "  2.[^-]*$" | tail -1)

RUBY_VER=$(rbenv install -l | grep -v - | tail -1)

echo $PYTHON3_VER
echo $PYTHON2_VER
echo $RUBY_VER

pyenv install $PYTHON3_VER -s && log_pass "python3: install successfully"
pyenv install $PYTHON2_VER -s && log_pass "python2: install successfully"
pyenv global $PYTHON3_VER $PYTHON2_VER
pyenv rehash

rbenv install $RUBY_VER -s && log_pass "ruby: install successfully"
rbenv global $RUBY_VER
