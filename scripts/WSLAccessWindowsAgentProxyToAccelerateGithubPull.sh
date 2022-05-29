#!/usr/bin/env bash

# 这个脚本用于WSL2连接windows的代理软件，加快拉取githubd仓库的速度。
# 7890是windows上暴露给代理软件的端口，同时注意windows代理软件需要允许局域网访问

hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
export ALL_PROXY="socks5://$hostip:7890"
