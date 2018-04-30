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

runningDistro=${1}
isTest=${2}

which -a msfconsole
if [ $? -eq 1 ];then #returns 0 if metasploit framework is installed.
    echo -e "${red}Metasploit Framework is not installed${nc} ${nc}"
    sleep 3s # wait before doing.

    echo -e "Installing Metasploit framework from ${yellow}'https://github.com/rapid7/metasploit-framework/wiki/Nightly-Installers'
        ${nc}Script invocation will import the Rapid7 signing key and setup the package for all supported Linux systems
        "
    sleep 5s #sleeping 5 seconds before installation begin.
    sudo curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall

    if [ $? -ne 0 ];then
        echo "Error occurred installing metasploit framework. ${red} Terminating.. ${nc}"
        exit 255
    fi
fi

### This portion of code works if Metasploit is already installed or jst installed.
## if user choose to not install, then it will exit immediately using code 255.

echo -e "${green}Metasploit Framework is installed!${nc}"
sleep 2s # sleeping b4 doing bullshit.

echo -e "
    ${yellow}1)${nc} Initialize the Database if it's not already initialized?
    ${yellow}2)${nc} Re-initialize the database it's already initialized?
    ${yellow}3)${nc} Database is configured correctly, Move on.
    "
echo -e "${cyan}
    -------------------------------------------
    -------------------------------------------
    I want to clarify that whatever you choose
    might have irreversible affect on your machine.
    I hope you know what you are doing
    -------------------------------------------
    -------------------------------------------
    ${nc}
    "
sleep 5s

### Test case for Metasploit Installation (in Silent Mode too)
if [ ${isTest} == 'True' ];then
    #reinit the db
    echo -e "${blue}Re-initializing the msf database${nc}"
    echo ""
    sleep 1s #wait 1 second

    if [ ${runningDistro} == 'Kali' ];then
        msfdb reinit
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            exit 255
        fi
    else
#        sudo -u ${SUDO_USER} msfdb reinit
        msfdb reinit
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            exit 255
        fi
    fi

    echo -e "${green}Metasploit framework database re-initialization complete ${nc}"
else

    for (( ; ; )) do
        read -n1 -p "Choose your option: " user_choice
        echo ""

        if (($user_choice == 1));then
            #init the db
            echo -e "${blue}Metasploit Framework db init${nc} needs to run as a ${blue}non-root user.${nc} You MAY need to provide your password... "
            echo ""
            sleep 1s #wait 1 second

            if [ ${runningDistro} == 'Kali' ];then
                echo ${runningDistro}
                msfdb init
                ## if the previous commit failed to run.
                if [ $? -ne 0 ];then
                    exit 255
                fi
            else
                echo ${runningDistro}
                sudo -u ${SUDO_USER} msfdb init
                ## if the previous commit failed to run.
                if [ $? -ne 0 ];then
                    exit 255
                fi
            fi

            echo -e "${green}Metasploit framework database initialization complete ${nc}"
            break
        elif (($user_choice == 2));then
            #reinit the db
            echo -e "${blue}Re-initializing the msf database${nc}"
            echo ""
            sleep 1s #wait 1 second

            if [ ${runningDistro} == 'Kali' ];then
                msfdb reinit
                ## if the previous commit failed to run.
                if [ $? -ne 0 ];then
                    exit 255
                fi
            else
                sudo -u ${SUDO_USER} msfdb reinit
                ## if the previous commit failed to run.
                if [ $? -ne 0 ];then
                    exit 255
                fi
            fi

            echo -e "${green}Metasploit framework database re-initialization complete ${nc}"
            break
        elif (($user_choice == 3));then
            #green
            echo -e "${green}Moving on${nc}"
            break
        else
            # unknown command. stop script.
            echo -e "Unknown command bro. Try again!"
        fi
    done
fi

sleep 2s
echo -e "Do you want to start the Metasploit Framework database now?
"

### Test case for Metasploit Installation (in Silent Mode too)
if [ ${isTest} == 'True' ];then
    printf "${blue}Starting msf database ${nc}"
    sleep 2s #sleep 2seconds before donning

    if [ ${runningDistro} == 'Kali' ];then
        msfdb start
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            exit 255
        fi
    else
#        sudo -u ${SUDO_USER} msfdb start
        msfdb start ## for testing travis environment.
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            exit 255
        fi
    fi
    printf "${green} -- Done \n ${nc}"
else
    read -n1 -p "Choose your option y/n: " user_choice
    echo ""

    if [ "${user_choice}" == "y" ] || [ "${user_choice}" == "Y" ]; then
        printf "${blue}Starting msf database ${nc}"
        sleep 2s #sleep 2seconds before donning

        if [ ${runningDistro} == 'Kali' ];then
            msfdb start
            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                exit 255
            fi
        else
            sudo -u ${SUDO_USER} msfdb start
            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                exit 255
            fi
        fi
        printf "${green} -- Done \n${nc}"
    fi
fi

exit 0 ## total success