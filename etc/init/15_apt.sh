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
  # update
  sudo apt update
  sudo apt -y upgrade

  # libraries
  sudo apt -y install build-essential
  sudo apt -y install make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev

  # install git
  sudo apt -y install git zsh gawk python3-pip

  # install Neovim
  sudo apt -y install software-properties-common
  sudo -E add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt -y install neovim

  # install Paper icons
  # sudo add-apt-repository ppa:snwh/ppa
  sudo add-apt-repository "deb http://ppa.launchpad.net/snwh/ppa/ubuntu disco main"
  sudo apt-get install paper-icon-theme
  # set the icon theme
  gsettings set org.gnome.desktop.interface icon-theme "Paper"
  # or the cursor theme
  gsettings set org.gnome.desktop.interface cursor-theme "Paper"

  # install chrome
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo apt update
  sudo apt install google-chrome-stable

  # change directory names
  LANG=C xdg-user-dirs-update --force

  sudo apt-get install dconf-cli
  rm -rf ~/gnome-terminal-colors-solarized
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git ~/gnome-terminal-colors-solarized
  cd ~/gnome-terminal-colors-solarized
  echo -e "1\n1\nYES\n1\n" | ./install.sh
  rm -rf ~/gnome-terminal-colors-solarized
  cd

  # for powerline
  sudo pip install powerline-shell


  # apt autoremove
  sudo apt autoremove
else
  log_fail "error: require: apt"
  exit 1
fi
