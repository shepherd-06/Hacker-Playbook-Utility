#!/usr/bin/env bash
green="\033[0;32m"
red="\033[0;31m"
cyan="\033[0;36m"
nc="\033[0m"
blue="\033[1;34m"
yellow="\033[1;33m"
lightPurple='\033[1;35m'

echo -e "${cyan} Escaping Update/Upgrade phase${nc}"
exit 200 # TODO: remove/comment this line.

echo -e "${lightPurple}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~Running Update && Upgrade ~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${nc}"

##TODO: need some design here
echo "Running the update command"
sudo apt update
#TODO: need some design here
echo -e "${green}update complete${nc}"
#TODO: need some design here
echo "Running Upgrade"
#TODO: need some design here | user confirmation is needed here.
sudo apt upgrade
#TODO: need some design here
echo -e "${green}Upgrade Complete${nc}"