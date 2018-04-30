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

#check if psql is installed.
which -a psql
if [ $? -eq 1 ] #returns 0 if psql is installed.
then
    echo -e "PostgreSQL is not installed" #install psql here.
    echo "${blue}Installing PostgreSQL....${nc}"
    sleep 3s # wait before doing.
    apt install postgresql postgresql-contrib #psql installation command
fi

if [ $? -ne 0 ];then
    exit 255
fi

sleep 2s
which -a psql
if [ $? -eq 0 ];then
    echo -e "${green}PostgreSQL is installed!${nc}"
    echo ""
else
    echo -e "Error occurred!"
    exit 255
fi


### Test script for Unit Testing - Start postgresql after booting up
## Silent mode enabled
if [ ${isTest} == 'True' ];then
    echo -e "$Configure PostgreSQL to start after server boots up?
    "
    sudo update-rc.d postgresql enable #configured psql to start upon booting
    if [ $? -ne 0 ];then
        exit 255
    fi
    echo -e "${green}Configuration Done${nc}"
else
    ## checker 1 for postgresl boot up after server start
    echo -e "Configure PostgreSQL to start after server boots up?
    "
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
    echo -e "Start PostgreSQL now?
    "
    sleep 3s # wait before doing.
    sudo service postgresql start #starting the postgresql server for the first time.

    if [ $? -ne 0 ];then
        exit 255
    fi
    echo -e "${green}PostgreSQL is running${nc}"
else
    ## checker 2 - for normal user
    echo -e "Start PostgreSQL now?
    "
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
    echo -e "${green}PostgreSQL database has been installed successfully and running properly!${nc}"
else
    #there is some error installing psql.
    #throwing the job to user. Terminating the script.
    echo -e "${red} There might be some issue with PostgreSQL connection creation!${nc}
    Terminating the script...."
    sleep 5s # wait before doing.
    ## if postgresql is not available, its useless to move forward!
    exit 255
fi

exit 0 ## mission success