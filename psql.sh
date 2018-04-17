#!/usr/bin/env bash

## ===========================##
## ===========================##
## Installing or managing PSQL##
## ===========================##
## ===========================##

echo "Checking if PostgreSQL is installed"
#check if psql is installed.
which -a psql
if [ $? -eq 1 ] #returns 0 if psql is installed.
then
    echo "PostgreSQL is not installed" #install psql here.
    echo "Installing PostgreSQL....\/\/\/"
    apt install postgresql postgresql-contrib #psql installation command
fi
echo "PostgreSQL is installed!"
printf "Configuring PostgreSQL to start upon server boot"
update-rc.d postgresql enable #configured psql to start upon booting
printf " -- Done\n"
printf "Starting POSTGRESQL...\/\/\/\/\/\/"
service postgresql start #starting the postgresql server for the first time.
printf " -- Done\n"

## checking postgresql connection status
if /usr/bin/pg_isready &> /dev/null;then #one final check if psql has been installed successfully
    printf "Postgresql database has been installed successfully and running properly!\n"
    printf "It is running in default configuration. Necessary documentation regarding default configuration will be found googling/postgresql official website.\n"
else
    #there is some error installing psql.
    #TODO: NEED a fucking try catch block here. If things does not work accordingly. Turn the python program off!
    echo "There might be some problem with postgresql connection creation!"
    echo "Shutting down the script!"
    kill $(pgrep -f 'main.py')
fi