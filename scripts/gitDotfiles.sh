#!/usr/bin/env bash
#########################################################################
# File Name: gitDotfiles.sh
# Author: Astro Shen
# mail: 768299856@qq.com
# Created Time: Mon Sep 27 20:08:30 2021
#########################################################################
set -Eeuxo pipefail

git init
git add .vimrc .bashrc .bash_profile .config/ .vim/


