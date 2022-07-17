#!/bin/bash
#########################################################################
# File Name: setup.sh
# Author: Astro Shen
# mail: 768299856@qq.com
# Created Time: Wed Nov 10 20:35:08 2021
#########################################################################
set -Eeuxo pipefail

my_home=${HOME}
if [ ! -d ${my_home}/.config ]; then
  echo "Make ${my_home}/.config/* directories..."
  mkdir -p ${my_home}/.config
fi
if [ ! -d ${my_home}/.local ]; then
  echo "Make ${my_home}/.local/* directories..."
  mkdir -p ${my_home}/.local/bin
  mkdir -p ${my_home}/.local/include
  mkdir -p ${my_home}/.local/share
fi
if [ ! -d ${my_home}/.tmp ]; then
  echo "Make ${my_home}/.tmp/* directories..."
  mkdir -p ${my_home}/.tmp/vim_swap
  mkdir -p ${my_home}/.tmp/tmux
  mkdir -p ${my_home}/.tmp/vim_undo
  mkdir -p ${my_home}/.tmp/vim_sessions
  mkdir -p ${my_home}/.tmp/gdb
fi

echo 'Setup all binarys'
awesome_tools=`ls awesome_tools`
for file in $awesome_tools
do
  cp -RfL ${PWD}/awesome_tools/${file} ${my_home}/.local/bin/$file
done

echo "Setup nvim..."
cp -RfL ${PWD}/nvim/ ${my_home}/.config/nvim
tar zxvf ${my_home}/.config/nvim/lsp_servers.tar.gz -C ${my_home}/.config/nvim/
tar zxvf ${my_home}/.config/nvim/lua.tar.gz -C ${my_home}/.config/nvim/
rm ${my_home}/.config/nvim/lua.tar.gz
rm ${my_home}/.config/nvim/lsp_servers.tar.gz

echo "Setup nnn..."
cp -RfL ${PWD}/nnn/ ${my_home}/.config/nnn

echo "Setup htop..."
cp -RfL ${PWD}/htop/ ${my_home}/.config/htop

echo "Setup fzf..."
cp -RfL ${PWD}/fzf/ ${my_home}/.config/fzf

echo "Setup tmux..."
cp -RfL ${PWD}/tmux/ ${my_home}/.tmux
cp -RfL ${PWD}/tmux/tmux.conf ${my_home}/.tmux.conf

echo "Setup zsh..."
cp -RfL ${PWD}/zsh/.zshrc ${PWD}/zsh/.zsh ${my_home}

echo "Setup scripts..."
cp -RfL ${PWD}/scripts/ ${my_home}

echo "Setup other hiddle files..."
cp -RfL ${PWD}/.gitconfig ${my_home}/.gitconfig
cp -RfL ${PWD}/.gdbinit ${my_home}/.gdbinit
