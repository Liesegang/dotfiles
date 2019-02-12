#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/etc/lib/vital.sh

if has "git"; then
  if ! [ -s $HOME/.zplug ]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    log_pass "zplug: install successfully"
  else
    log_pass "zplug: already installed"
  fi
else
    log_fail "error: require: git"
    exit 1
fi

