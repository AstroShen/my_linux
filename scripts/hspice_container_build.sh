#!/bin/bash
cd ~/work
docker build -t hspice . 
docker run -it -p 5902:5902 --name hspice -v /home/astro/work/:/home/ --hostname lizhen --mac-address 02:42:ac:11:00:02 luckyhang/hspice
