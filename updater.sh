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
sudo apt update
echo -e "${green}update complete${nc}"
echo -e "${blue} Upgrading ${nc}"
sudo apt upgrade
echo -e "${green}Upgrade Complete${nc}"