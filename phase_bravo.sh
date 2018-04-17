#!/usr/bin/env bash

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "!Running Phase BRAVO Installation!"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

#----------------------------------------
#SMBExec Installation!
#----------------------------------------
function SMBExec() {
    printf "\n\n#####################################\n"
    echo "#####################################"
    echo "Hello World"
}

#----------------------------------------
#Discover Installation!
#----------------------------------------
function discover() {
    printf "\n\n#####################################\n"
    printf "#####################################\n"
    echo "Installing Discover Scripts. [Originally called Backtrack - Scripts"
    echo "Discover is used for Passive Enumeration!"

    discover_directory=/opt/discover
    if [ ! -d ${discover_directory} ];then
        #    discover clone and install
        cd /opt/ && git clone https://github.com/leebaird/discover.git
        echo ""
        printf "#####################################\n"
        printf "#####################################\n"
        echo "Successfully cloned from Github. Running update.sh script. This may take a while"
#        chmod a+x /opt/discover/update.sh
#        cd /opt/discover && ./update.sh
        printf "Updating Discover -- DONE\n"
        SMBExec # go to SMBExec. Discover is done.
    else
        #   discover folder already exist.
        echo ""
        printf "#####################################\n"
        printf "#####################################\n"
        echo "A folder named discover already exist! Choose your options:
        1) Discover is already installed. Move on!
        2) Remove the Discover folder, Re-clone and Install
        3) I need to figure this out. Stop this script"
        read -p "Please type [1,2,3]" user_option
        echo ""
        printf "#####################################\n"
        printf "#####################################\n"
        if (($user_option == 1 ));then
            echo "Moving on..."
            SMBExec # go to SMBExec to execute from there.
        elif (($user_option == 2));then
            echo "Removing OLD discover and cloning again from github"
            rm -rf /opt/discover/
            cd /opt/ && git clone https://github.com/leebaird/discover.git
            echo "Successfully cloned from Github. Running update.sh script. This may take a while"
            chmod a+x /opt/discover/update.sh
            cd /opt/discover && ./update.sh
            printf "Updating Discover -- DONE\n"
            SMBExec # go to SMBExec. Discover is done.
        else
            echo "Terminating the script. Superheroes need help too. Take help from googloooooooo! :)"
            exit -1
            # user choose to terminate the script.
            # no new function will be called from here.
        fi
    fi
}


discover #discover will be called first.
#In order to keep the flow intact discover will call the later functions accordingly