#!/usr/bin/env bash
green="\033[0;32m"
red="\033[0;31m"
cyan="\033[0;36m"
nc="\033[0m"
blue="\033[1;34m"
yellow="\033[1;33m"
lightPurple='\033[1;35m'

#echo -e "${cyan} Escaping Update/Upgrade phase${nc}"

echo -e "${lightPurple}
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~ Update && Upgrade ~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${nc}"

echo -e "${blue} Updating ${nc}"
sleep 3s # wait before doing.
sudo apt update
echo -e "
    ${cyan}-------------------------------------------${nc}
    ${green}update complete${nc}
    ${cyan}-------------------------------------------${nc}
    ${blue} Upgrading ${nc}
    ${cyan}-------------------------------------------${nc}"
sleep 3s # wait before doing.
sudo apt upgrade
echo -e "${cyan}-------------------------------------------${nc}
    ${green}Upgrade Complete${nc}
    ${cyan}-------------------------------------------${nc}"