#!/usr/bin/env bash

if [ ! -d "$HOME/.backup" ]; then
    mkdir ~/.backup;
    echo "Build directory ~/.backup!";
fi

# spacevim tarball
zip -qry ~/.backup/spacevim.zip ~/.SpaceVim/ ~/.SpaceVim.d/ ~/.cache/ ~/.local/ ~/.vim/

# dotfiles tarball
zip -qr ~/.backup/dotfiles.zip ~/.dotfiles/

# myscripts tarball
zip -qr ~/.backup/my_scripts.zip ~/my_scripts/

# softwares tarball
zip -qr ~/.backup/softwares.zip ~/softwares/

echo "Completed! All files are in ~/.backup!"
