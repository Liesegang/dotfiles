 #!/bin/bash

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles; export DOTPATH
fi

backup_dir=${HOME}/.backup_dotfiles

cd $DOTPATH

for f in *
do
    [[ ${f} = ".DS_Store" ]] && continue
    [[ ${f} = "README.md" ]] && continue
    [[ ${f} = ".git" ]] && continue
    [[ ${f} = ".gitignore" ]] && continue
    [[ ${f} = "etc" ]] && continue
    [[ ${f} = "doc" ]] && continue
    [[ ${f} = "bin" ]] && continue
    [[ ${f} = "install.sh" ]] && continue
    [[ ${f} = "vimrc" ]] && continue

    # remove ln which already exit
    if [ -L ${HOME}/.${f} ]; then
        rm ${HOME}/.${f}
    fi

    # move dotfiles which already exit
    if [ -e ${HOME}/.${f} ]; then
        mkdir ${backup_dir}
        mv ${HOME}/.${f} ${backup_dir}/${f}
    fi

    # Create links for dotfiles
    ln -snfv $DOTPATH/${f} ${HOME}/.${f}
done

# Create links for bin
ln -snfv ${DOTPATH}/bin ${HOME}/bin
mkdir -p ~/.config/nvim
ln -snfv ${DOTPATH}/vimrc ${HOME}/.config/nvim/init.vim

# Show comlete message
echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
