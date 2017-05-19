#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/etc/lib/vital.sh

# This script is only supported with OS X
if ! is_osx; then
    log_fail "error: this script is only supported with osx"
    exit 1
fi

if has "git"; then
	if ! has "anyenv"; then
		git clone https://github.com/riywo/anyenv ~/.anyenv
		log_pass "anyenv: install successfully"
	else
		log_pass "anyenv: already installed"
	fi
else
    log_fail "error: require: git"
    exit 1
fi

anyenv install pyenv -s
anyenv install rbenv -s

PYTHON3_VER=$(pyenv install -l | grep -E "  3.[^-]*$" | tail -1)
PYTHON2_VER=$(pyenv install -l | grep -E "  2.[^-]*$" | tail -1)

RUBY_VER=$(rbenv install -l | grep -v - | tail -1)

pyenv install $PYTHON3_VER -s
pyenv install $PYTHON2_VER -s
pyenv global $PYTHON3_VER $PYTHON2_VER
pyenv rehash

rbenv install $RUBY_VER -s
rbenv global $RUBY_VER