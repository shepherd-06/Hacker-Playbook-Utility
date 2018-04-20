#!/usr/bin/env bash
green="\033[0;32m"
red="\033[0;31m"
cyan="\033[0;36m"
nc="\033[0m"
blue="\033[1;34m"
yellow="\033[1;33m"
lightPurple='\033[1;35m'

echo -e "${lightPurple}
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~Metasploit Framework~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ${nc}"

#    The following script invocation will import the Rapid7 signing key and setup the package for all supported Linux and OS X systems:

which -a msfconsole
if [ $? -eq 1 ] #returns 0 if psql is installed.
then
    echo -e "${red}Metasploit Framework is not installed${nc}
    Do you want this script to install the Metasploit framework?
    ${red}Caution: ${nc} This scripts and any other script won't work without Metasploit framework. ${nc}"
    sleep 3s # wait before doing.
    read -n1 -p "Choose 1 if you want this script to install Metasploit or any key otherwise " user_choice
    echo ""

    if (($user_choice == 1));then
        echo -e "${blue} Installing MetaSploit framework from ${yellow}'https://github.com/rapid7/metasploit-framework/wiki/Nightly-Installers' ${nc}"
        sleep 5s #sleeping 5 seconds before installation begin.
        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
    else
        echo ""
    fi
else
    echo -e "${green}MetaSploit Framework is installed!${nc}
    ${blue} Do you want to re-initializing the database (if already installed) or keep it as it is? ${nc}"
    sleep 2s # sleeping b4 doing bullshit.
    read -n1 -p "Choose 1 for initializing, any key if you want to move on... " user_choice

    if (($user_choice == 1));then
        msfdb init
    fi
fi