#!/usr/bin/env bash
#########################################################################
# File Name: dependency.sh
# Author: Astro Shen
# mail: 768299856@qq.com
# Created Time: Wed Nov 10 18:03:37 2021
#########################################################################
set -Eeuxo pipefail

# install pack for nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install clangd
wget https://github.com/clangd/clangd/releases/download/snapshot_20200217/clangd-linux-snapshot_20200217.zip
unzip clangd-linux-snapshot_20200217.zip
cp -r clangd_snapshot_20200217/bin clangd_snapshot_20200217/lib /home/astro/.local
rm -rf clangd_snapshot_20200217/
