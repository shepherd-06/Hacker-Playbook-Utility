#!/usr/bin/env bash
green="\033[0;32m"
red="\033[0;31m"
cyan="\033[0;36m"
nc="\033[0m"
blue="\033[1;34m"
yellow="\033[1;33m"
lightPurple='\033[1;35m'

isTest=${1}
echo -e "${yellow}
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${lightPurple}
            #  # #### #    #     ###    ##     ##  ###  #### #    ###
            #### ##   #    #    #   #    #  #  #  #   # # #  #    #  #
            #  # #### #### ####  ###      ## ##    ###  #  # #### ###
    ${yellow}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${nc}"

echo -e "
    ${yellow}-------------------------------------------${nc}
    ${blue}Updating ${nc}
    ${yellow}-------------------------------------------${nc}
    "
sleep 3s # wait before doing.
if [ ${isTest} == 'True' ];then
    ## force Upgrades can break things. Use this on your own risk.
    ## This does not run properly in travisCI
    echo ""
    sudo apt update > /dev/null ## running in force installation mode
else
    sudo apt update
fi

if [ $? -ne 0 ];then
    echo "update crashed"
    exit 255
fi

echo -e "
    ${yellow}-------------------------------------------${nc}
    ${green}Update complete${nc}
    ${yellow}-------------------------------------------${nc}
    ${blue}Upgrading ${nc}
    ${yellow}-------------------------------------------${nc}
    "
sleep 3s # wait before doing.

if [ ${isTest} == 'True' ];then
    ## force Upgrades can break things. Use this on your own risk.
    ## This does not run properly in travisCI
    echo ""
#    sudo apt upgrade -y --fix-missing > /dev/null ## running in force installation mode
else
    sudo apt upgrade --fix-missing
fi

if [ $? -ne 0 ];then
    echo "System upgrade crashed"
    exit 255
fi

echo -e "
    ${yellow}-------------------------------------------${nc}
    ${green}Upgrade Complete${nc}
    ${yellow}-------------------------------------------${nc}
    "
exit 0 ##success
