#!/usr/bin/env bash
#########################################################################
# File Name: before_commit.sh
# Author: Astro Shen
# mail: 768299856@qq.com
# Created Time: Wed Nov 10 22:58:01 2021
#########################################################################
set -Eeuxo pipefail

# nvim
rm -rf ./nvim/*
cp -rf ~/.config/nvim/init.lua ~/.config/nvim/lua/ ~/.config/nvim/after/ ./nvim/
tar zcvf ./nvim/lsp_servers.tar.gz -C  ~/.config/nvim/ lsp_servers
tar zcvf ./nvim/lua.tar.gz -C ~/.config/nvim/ lua
echo 'nvim update done!'

# nnn
cp -rf ~/.config/nnn/plugins/ ./nnn
echo 'nnn update done!'

# fzf
cp -rf ~/.config/fzf .
echo 'fzf update done!'

# htop
cp -rf ~/.config/htop .
echo 'htop update done!'

# tmux
cp -rf ~/.tmux/* ./tmux/
echo 'tmux update done!'

# scripts
cp -r ~/scripts/* ./scripts/
echo 'scripts update done!'

# zsh
cp -rf ~/.zshrc ~/.zsh ./zsh/
echo 'shell update done!'

# gdb
cp -v ~/.gdbinit .
cp -v ~/.gitconfig .
echo 'gitconfig, gdbinit, etc. other useful config files done!'

find . -mindepth 2 -name '.git' -type d -print0 | xargs -0 rm -rf
find . -mindepth 2 -name '.git*' -type f -print0 | xargs -0 rm -rf
echo 'removed all .git repositories and .git* files'

git add .
git commit -m "update"
git push
