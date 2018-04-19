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
#echo -e "${cyan} Escaping PostgreSQL Installation phase${nc}"
#exit 200 #### TODO REPLACE this line

echo -e "${lightPurple}
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~ PostgreSQL Status~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ${nc}"

echo -e "${yellow}Checking if PostgreSQL is installed${nc}"
#check if psql is installed.
which -a psql
if [ $? -eq 1 ] #returns 0 if psql is installed.
then
    echo -e "${red}PostgreSQL is not installed${nc}" #install psql here.
    echo "${blue}Installing PostgreSQL....${nc}"
    apt install postgresql postgresql-contrib #psql installation command
fi

echo -e "${green}PostgreSQL is installed!${nc}"
printf "Configuring PostgreSQL to start upon server boot"
update-rc.d postgresql enable #configured psql to start upon booting
printf " -- ${green}Done${nc}\n"

printf "Starting PostgreSQL.."
service postgresql start #starting the postgresql server for the first time.
printf " -- ${green}Done${nc}\n"


## checking postgresql connection status
if /usr/bin/pg_isready &> /dev/null;then #one final check if psql has been installed successfully
    printf "${green}Postgresql database has been installed successfully and running properly!${nc}\n"
    printf "It is running in ${yellow}default configuration.${nc} Necessary documentation regarding default configuration will be found googling/postgresql official website.\n"
else
    #there is some error installing psql.
    #throwing the job to user. Terminating the script.
    echo -e "${red} There might be some problem with PostgreSQL connection creation!${nc}
    Do you want to check this out or proceed? ${cyan} It's important that PostgreSQL server is properly configured before you doing anything else ${nc}
    1) Check this out"
    read -p "Please Choose between [1,2] : " user_option
    echo ""
        if (($user_option == 1 ));then
            echo -e "${red}Shutting down the script!${nc}"
            kill $(pgrep -f 'main.py')
        else
            echo -e "${cyan}Moving on.....${nc}"
        fi
fi