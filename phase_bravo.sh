#!/usr/bin/env bash

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "!Running Phase BRAVO Installation!"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

#----------------------------------------
#Veil version 3.0 Installation!
#----------------------------------------
function Veil() {
    echo "Happy Birthday"
}


#----------------------------------------
#SMBExec Installation!
#----------------------------------------
function SMBExec() {
    echo ""
    echo "#####################################"
    echo "#####################################"
    echo ""
    echo "2) Installing SMBExec"
    echo "SMBExec will be used to grab hashes out of Domain Controller and reverse shells"
    echo ""
    SMBExec_directory=/opt/smbexec
    if [ ! -d ${SMBExec_directory} ];then
        # install SMBExec
        cd /opt/ && git clone https://github.com/brav0hax/smbexec.git
        chmod a+x /opt/smbexec/install.sh
        echo "I am going to run the install.sh script of SMBExec. You will need to choose Option 1 for step 1. Then Choose your current directory location (/opt/) by hitting ENTER key. Finally Choose number 4 (for unknown/if needed request)"
#        cd /opt/smbexec && ./install.sh
        echo "Hopefully you have successfully installed SMBExec. It's a bit tricky. Take help from the book, if needed."
        Veil
    else
        # directory exists.
        echo "A folder named SMBExec already exist! Choose your options:
        1) SMBExec is already installed. Move on!
        2) Remove the SMBExec folder, Re-clone and Install fresh
        3) I need to figure this out. Stop this script"
        read -p "Please Choose between [1,2,3]" user_option
        echo ""
        echo "#####################################"
        echo "#####################################"
        echo ""
        if (($user_option == 1 ));then
            echo "Moving on..."
            Veil # go to SMBExec to execute from there.
        elif (($user_option == 2));then
            echo "Removing OLD discover and cloning again from github"
            rm -rf /opt/smbexec/
            cd /opt/ && git clone https://github.com/brav0hax/smbexec.git
            echo "Successfully cloned from Github. Running update.sh script. This may take a while"
            chmod a+x  /opt/smbexec/install.sh
#            cd /opt/smbexec && ./install.sh
            printf "Updating Discover -- DONE\n"
            Veil # go to Veil. SMBExec is done.
        else
            echo "Terminating the script. Superheroes need help too. Take help from googloooooooo! :)"
            exit -1
            # user choose to terminate the script.
            # no new function will be called from here.
        fi
    fi
}


#----------------------------------------
#Discover Installation!
#----------------------------------------
function discover() {
    echo ""
    echo "#####################################"
    echo "#####################################"
    echo ""
    echo "Installing Discover Scripts. [Originally called Backtrack - Scripts"
    echo "Discover is used for Passive Enumeration!"

    discover_directory=/opt/discover
    if [ ! -d ${discover_directory} ];then
        #    discover clone and install
        cd /opt/ && git clone https://github.com/leebaird/discover.git
        echo ""
        echo "#####################################"
        echo "#####################################"
        echo ""
        echo "Successfully cloned from Github. Running update.sh script. This may take a while"
#         TODO: UNCOMMENT the following TWO LINE for production
#        chmod a+x /opt/discover/update.sh
#        cd /opt/discover && ./update.sh
        echo "Updating Discover -- DONE"
        SMBExec # go to SMBExec. Discover is done.
    else
        #   discover folder already exist.
        echo ""
        echo "#####################################"
        echo "#####################################"
        echo ""
        echo "A folder named discover already exist! Choose your options:
        1) Discover is already installed. Move on!
        2) Remove the Discover folder, Re-clone and Install
        3) I need to figure this out. Stop this script"
        read -p "Please type [1,2,3]" user_option
        echo ""
        echo "#####################################"
        echo "#####################################"
        echo ""
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
            echo "Updating Discover -- DONE"
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