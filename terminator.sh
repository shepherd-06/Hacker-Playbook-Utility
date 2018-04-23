#!/usr/bin/env bash
green="\033[0;32m"
red="\033[0;31m"
cyan="\033[0;36m"
nc="\033[0m"
blue="\033[1;34m"
yellow="\033[1;33m"
lightPurple='\033[1;35m'

echo ${2}
if (( ${1} == 1 ));then
        echo -e "
        ${yellow}----------------------------------
        ----------------------------------
        ----------------------------------
        ${red}An Error occurred while Running the following command
        ${cyan}${2}
        ${red}Script terminated
        ${yellow}----------------------------------
        ----------------------------------
        ----------------------------------${nc}
        "
fi
kill $(pgrep -f 'HP-Utility')