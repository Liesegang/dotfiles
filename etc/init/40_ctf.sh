#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/etc/lib/vital.sh

# This script is only supported with OS X
if ! is_linux; then
  log_info "error: this script is only supported with linux"
  exit
fi

if has "apt"; then
  # for ctf
  # for x86
  sudo dpkg --add-architecture i386
  sudo apt update
  sudo apt -y install libc6:i386 libncurses5:i386 libstdc++6:i386 gcc-multilib g++-multilib

  # install
  sudo apt -y install binutils socat nasm gdb

  # exgdb
  git clone https://github.com/miyagaw61/exgdb.git ~/.exgdb
  cd ~/.exgdb
  sudo cp -a ./bin/exgdbctl /usr/local/bin
  exgdbctl install expeda
  exgdbctl install Pwngdb
  cd
else
  log_fail "error: require: apt"
  exit 1
fi
