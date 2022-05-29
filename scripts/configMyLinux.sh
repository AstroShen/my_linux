#!/usr/bin/env bash
#########################################################################
# File Name: configMyLinux.sh
# Author: Astro Shen
# mail: 768299856@qq.com
# Created Time: Sun Sep 12 16:18:05 2021
#########################################################################
set -Eeo pipefail

DIRNAME="/home/astro"
TARBALLNAME="MyLinuxConfig.tar.gz"
while getopts 'i:co:xd:' OPTION; do
    case "$OPTION" in
        i)
            TARBALLNAME="$OPTARG"
            ;;
        c)
            COMPRESS=1
            ;;
        o)
            TARBALLNAME="$OPTARG"
            ;;
        x)
            CONFIG=1
            ;;
        d)
            DIRNAME="$OPTARG"
            ;;
        ?)
            echo "script usage :$(basename "$0") [-c] [-x] [-d] [-o output tar ball name]" >&2
            exit 1
            ;;
    esac
done
[[ "$COMPRESS" && "$CONFIG" ]] && echo " option [-c] and [-x] cannot be specified at the same time" && exit 1

CONFIGDIR=${DIRNAME}/.config
VIMDIR=${DIRNAME}/.vim
LOCALDIR=${DIRNAME}/.local
SCRIPTDIR=${DIRNAME}/scripts

BASH_PROFILE="${CONFIGDIR}"/bash/.bash_profile
BASHRC="${CONFIGDIR}"/bash/.bashrc
VIMRC="${VIMDIR}"/.vimrc

# 打包压缩当前Linux环境
if [ "$COMPRESS" ]; then
    cp -v ~/.bash_profile "${BASH_PROFILE}"
    cp -v ~/.bashrc "${BASHRC}"
    cp -v ~/.vimrc "${VIMRC}"
    tar zcf "${TARBALLNAME}" "${CONFIGDIR}" "${VIMDIR}" "${LOCALDIR}"
fi


# 将shell配置等文件移动到相应的目录
if [ "$CONFIG" ]; then
    [ ! -d "${CONFIGDIR}" ] && echo "${CONFIGDIR} not exits!" && exit 1
    cp -vb "${BASH_PROFILE}" "${BASHRC}" "${VIMRC}" ~
    . ~/.bash_profile
fi

