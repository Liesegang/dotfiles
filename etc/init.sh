 #!/bin/bash

#     | |     | |  / _(_) |           
#   __| | ___ | |_| |_ _| | ___  ___  
#  / _` |/ _ \| __|  _| | |/ _ \/ __| 
# | (_| | (_) | |_| | | | |  __/\__ \ 
#  \__,_|\___/ \__|_| |_|_|\___||___/ 

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles; export DOTPATH
fi

cd $DOTPATH/etc/init/

for f in *.sh
do
	bash ${f}
done

echo $(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)