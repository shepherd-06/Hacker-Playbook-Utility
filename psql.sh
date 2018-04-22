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
#./terminator.sh 1 "Testing"
#exit 255

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
    ./terminator.sh 1 "apt install postgresql postgresql-contrib"
    exit 255
fi

echo -e "${green}PostgreSQL is installed!${nc}"
echo ""
sleep 2s

## checker 1
echo -e "${blue}Do you want to configure PostgreSQL to start after server boots up?${nc}"
echo ""
read -n1 -p "Choose your option [y/n]: " user_choice
echo ""

if (( $user_choice == "y" )) || (( $user_choice == "Y")); then
    printf "Configuring PostgreSQL to start upon server boot"
    sleep 3s # wait before doing.
    update-rc.d postgresql enable #configured psql to start upon booting

    if [ $? -ne 0 ];then
    ./terminator.sh 1 "update-rc.d postgresql enable"
    exit 255
    fi
    printf " -- ${green}Done${nc}\n"
fi


## checker 2
echo -e "${blue}Do you want to start PostgreSQL now?${nc}"
echo ""
read -n1 -p "Choose your option [y/n]: " user_choice
echo ""

if (( $user_choice == "y" )) || (( $user_choice == "Y")); then
    printf "Starting PostgreSQL.."
    sleep 3s # wait before doing.
    service postgresql start #starting the postgresql server for the first time.

    if [ $? -ne 0 ];then
    ./terminator.sh 1 "service postgresql start"
    exit 255
    fi
    printf " -- ${green}Done${nc}\n"
fi


## checking postgresql connection status
if /usr/bin/pg_isready &> /dev/null;then #one final check if psql has been installed successfully
    echo -e "${green}PostgreSQL database has been installed successfully and running properly!${nc}.
It is running in ${yellow}default configuration.${nc} Necessary documentation regarding default configuration will be found googling/postgresql official website.\n"
else
    #there is some error installing psql.
    #throwing the job to user. Terminating the script.
    echo -e "${red} There might be some problem with PostgreSQL connection creation!${nc}
    Do you want to check this out or proceed? ${cyan} It's important that PostgreSQL server is properly configured before you doing anything else ${nc}
    1) Check this out"
    sleep 5s # wait before doing.
    read -p "Please Choose between [1,2] : " user_option
    echo ""
        if (($user_option == 1 ));then
            echo -e "${red}Shutting down the script!${nc}"
            ./terminator.sh 2 ""
            exit 255
        else
            echo -e "${cyan}Moving on.....${nc}"
        fi
fi