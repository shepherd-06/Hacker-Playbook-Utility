#!/usr/bin/env bash
green="\033[0;32m"
red="\033[0;31m"
cyan="\033[0;36m"
nc="\033[0m"
blue="\033[1;34m"
yellow="\033[1;33m"
lightPurple='\033[1;35m'

## ===========================##
## ===========================##
## Installing or managing PSQL##
## ===========================##
## ===========================##
#exit 255
isTest=${1}

echo -e "${lightPurple}
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~ PostgreSQL Status~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ${nc}"

echo -e "${blue}Checking if PostgreSQL is installed${nc}"
#check if psql is installed.
which -a psql
if [ $? -eq 1 ] #returns 0 if psql is installed.
then
    echo -e "${red}PostgreSQL is not installed${nc}" #install psql here.
    echo "${blue}Installing PostgreSQL....${nc}"
    sleep 3s # wait before doing.
    apt install postgresql postgresql-contrib #psql installation command
fi

if [ $? -ne 0 ];then
    exit 255
fi

echo -e "${green}PostgreSQL is installed!${nc}"
echo ""
sleep 2s


### Test script for Unit Testing - Start postgresql after booting up
## Silent mode enabled
if [ ${isTest} == 'True' ];then
    echo -e "${blue}Configure PostgreSQL to start after server boots up?${nc}"
    echo ""
    sudo update-rc.d postgresql enable #configured psql to start upon booting
    if [ $? -ne 0 ];then
        exit 255
    fi
    echo -e "${green}Configuration Done${nc}"
else
    ## checker 1 for postgresl boot up after server start
    echo -e "${blue}Configure PostgreSQL to start after server boots up?${nc}"
    echo ""
    read -n1 -p "Choose your option [y/n]: " user_choice
    echo ""

    if [ "${user_choice}" == "y" ] || [ "${user_choice}" == "Y" ]; then
        echo -e "Configuring PostgreSQL to start upon server boot"
        sleep 3s # wait before doing.
        update-rc.d postgresql enable #configured psql to start upon booting

        if [ $? -ne 0 ];then
            exit 255
        fi
        echo -e "${green}Configuration Done${nc}"
    fi
fi


### Test script for Unit Testing PostgreSQL start
## Silent Mode enabled.
if [ ${isTest} == 'True' ];then
    echo -e "${blue}Start PostgreSQL now?${nc}"
    echo ""
    sleep 3s # wait before doing.
    sudo service postgresql start #starting the postgresql server for the first time.

    if [ $? -ne 0 ];then
        exit 255
    fi
    echo -e "${green}PostgreSQL is running${nc}"
else
    ## checker 2 - for normal user
    echo -e "${blue}Start PostgreSQL now?${nc}"
    echo ""
    read -n1 -p "Choose your option [y/n]: " user_choice
    echo ""
    if [ "${user_choice}" == "y" ] || [ "${user_choice}" == "Y" ]; then
        echo -e "Starting PostgreSQL.."
        sleep 3s # wait before doing.
        service postgresql start #starting the postgresql server for the first time.

        if [ $? -ne 0 ];then
            exit 255
        fi
        echo -e "${green}PostgreSQL is running${nc}"
    fi
fi


## checking postgresql connection status
if /usr/bin/pg_isready &> /dev/null;then #one final check if psql has been installed successfully
    echo -e "${green}PostgreSQL database has been installed successfully and running properly!${nc}.
    It is running in ${yellow}default configuration.${nc}
    Necessary documentation regarding default configuration will be found googling/postgresql official website."
else
    #there is some error installing psql.
    #throwing the job to user. Terminating the script.
    echo -e "${red} There might be some problem with PostgreSQL connection creation!${nc}
    Do you want to check this out or proceed? ${cyan}
    It's important that PostgreSQL server is properly configured before you doing anything else ${nc}
    1) Terminate script
    2) Press any key otherwise..."

    sleep 5s # wait before doing.

    ### Test script for Unit Testing
    ## Silent Test Mode.
    if [ ${isTest} == 'True' ];then
        echo -e "${red}Shutting down the script!${nc}"
        exit 255
    else
        read -p "Please Choose between [1,2] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${red}Shutting down the script!${nc}"
            exit 255
        else
            echo -e "${yellow}Moving on.....${nc}"
        fi
    fi
fi

exit 0 ## mission success