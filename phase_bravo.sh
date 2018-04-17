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
!Running Phase BRAVO Installation!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{nc}"

#----------------------------------------
#Downloading Different files using WGET
#----------------------------------------
function little_wget_magic() {
    echo -e "${yellow}-------------------------------
    ${blue} Running a little WGET magic to download ${cyan}WCE (Windows Credential Editor), Mimikatz, Custom Password Lists, PeepingTom, NMap Script, PowerSploit, Responder, SET (Social Engineering Toolkit), BypassUAC and Fuzzing Lists.
    ${blue} This list is so f**king long, I know....
    ${yellow}-------------------------------${nc}"

    backup_directory=~/backup_wget

    # WCE
    echo -e "${blue} Download WCE (Windows Credential Editor) ${nc}.
    Windows Credential Editor will be used to pull password from memory."
    cd ~/Desktop/ && wget http://www.ampliasecurity.com/research/wce_v1_41beta_universal.zip
    unzip -d ~/Desktop/wce wce_v1_41beta_universal.zip
    if [ ! -d ${backup_directory} ];then
        mkdir ~/backup_wget
    fi
    mv ~/Desktop/wce_v1_41beta_universal.zip ~/backup_wget/
    echo -e "${green}WCE is downloaded and unzipped in ~/Desktop/wce. zipped backup is kept in ~/backup_wget/ directory${nc}"


    #Mimikatz
    echo -e "${blue} Download Mimikatz ${nc}.
    Mimikatz will be used to pull password from memory."
    cd ~/Desktop/ && wget http://blog.gentilkiwi.com/downloads/mimikatz_trunk.zip
    unzip -d ~/Desktop/mimikatz mimikatz_trunk.zip
    if [ ! -d ${backup_directory} ];then
        mkdir ~/backup_wget
    fi
    mv ~/Desktop/mimikatz_trunk.zip ~/backup_wget/
    echo -e "${green}Mimikatz is downloaded and unzipped. A backup is kept as well.${nc}"


    # --------- Custom Password list ---------
    # Skill Security

    custom_password_directory=~/Desktop/password_list/
    custom_password_bk=~/backup_wget/password_list/
    echo -e "${blue}Download Custom Password list.${nc}
    First. Rock you of Skull Security"
    cd ~/Desktop/ && wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
    if [ ! -d ${custom_password_directory} ];then
        mkdir ~/Desktop/password_list/
    fi
    bzip2 rockyou.txt.bz2
    if [ ! -d ${custom_password_bk} ];then
        mkdir ~/backup_wget/password_list/
    fi
    mv ~/Desktop/password_list/ ~/backup_wget/password_list/
    echo -e "${green}Downloaded Rock you file of Skull Security${nc}
    ${blue}Downloading Human password list of CrackStation${nc}
    ${cyan}The list is free however, CrackStation has a donation page running for whatever amount you wish. If you feel, follow this url: ${yellow} https://crackstation.net/buy-crackstation-wordlist-password-cracking-dictionary.htm${nc}

    Do you want to Download ${blue}CrackStation password list ${nc} using Torrent or HTTP Mirror? It's a ${blue}247 MB${nc} of GZIP compressed file.
    ${blue}Choose 1, if you want Torrent (Fast).
    Choose 2, if you want to use HTTP Mirror (Bit Slower) ${nc}"

    read -n1 -p "Please Choose between [1,2] : " user_option
    if (($user_option == 1 ));then
        cd ~/Desktop/ && wget https://crackstation.net/downloads/crackstation-human-only.txt.gz.torrent
        which -a transmission-gtk
        if [ $? -eq 0 ];then
            transmission-gtk ~/Desktop/crackstation-human-only.txt.gz.torrent
            sleep 5s # sleep 5 seconds for this command to finish
            echo "${green}I am guessing Transmission is downloading the crackstation's file. Moving on... ${nc}"
        else
            #TODO  --------- --------- --------- --------- --------- ---------
            echo "TODO: Transmission is not installed. Tell the user to Download via HTTP mirror or Use any other torrent manager."
        fi
    else
        #TODO  --------- --------- --------- --------- --------- ---------
        echo "HTTP Mirror | wget magic"
        cd ~/Desktop/ && wget https://crackstation.net/files/crackstation-human-only.txt.gz
        if [ ! -d ${custom_password_directory} ];then
            mkdir ~/Desktop/password_list/
        fi
    fi
}

#----------------------------------------
#Veil version 3.0 Installation!
#TODO: Need to check Veil from Kali------
#----------------------------------------
function Veil() {
    echo -e "${yellow}-------------------------------
    ${blue} Veil Evasion is not Longer supported. ${cyan}Currently running Veil 3.0.0
    ${blue} I am going to clone from ${yellow} https://github.com/Veil-Framework/Veil
    ${blue} Would you like to continue?${nc}"

    read -n1 -p "Choose y for yes, n for no : " user_option
    echo ""
    if [ "$user_option" = "n" ] || [ "$user_option" = "N" ];then
        echo -e "${red}Terminating the script. ${green}Good luck! :)${nc}"
        exit -1
    fi

    Veil_Directory=/opt/Veil
    if [ ! -d ${Veil_Directory} ];then
        # install Veil
        cd /opt/ && git clone https://github.com/Veil-Framework/Veil
        chmod a+x /opt/Veil/Veil.py
        chmod a+x /opt/Veil/config/update-config.py
        printf "${green}Successfully cloned Veil.${nc} Updating Configuration now..."
        cd /opt/Veil/config && ./update-config.py
        printf "${green}Done.\n${nc}Running installation now."
        cd /opt/Veil && ./Veil.py --setup
        prinf " -- ${green}Complete\n${nc}"
        little_wget_magic # go to Someplace else
    else
        # directory exists.
        echo -e "${red}A folder named Veil already exist!${nc} Choose your options:
        1) Veil is already installed. ${green}Move on!${nc}
        2) ${red}Remove${nc} the Veil folder, Re-clone and Install fresh
        3) Do not Remove Veil. ${green}Re-configure and Re-install${nc} again
        4) I need to figure this out. ${red}Stop this script${nc}"
        read -n1 -p "Please Choose between [1,2,3]" user_option
        echo "
        "
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
            little_wget_magic # go to Other places from here to execute from there.
        elif (($user_option == 2));then
            echo -e "Removing OLD Veil and cloning again from github"
            rm -rf /opt/Veil/
            cd /opt/ && git clone https://github.com/Veil-Framework/Veil
            chmod a+x /opt/Veil/Veil.py
            chmod a+x /opt/Veil/config/update-config.py
            printf "${green}Successfully cloned Veil.${nc} Updating Configuration now... "
            cd /opt/Veil/config && ./update-config.py
            printf "${green}Done.${nc} \nRunning installation now."
            cd /opt/Veil && ./Veil.py --setup
            prinf " -- ${green}Complete${nc}\n"
            little_wget_magic # go to Someplace else
        elif (($user_option == 3));then
            chmod a+x /opt/Veil/Veil.py
            chmod a+x /opt/Veil/config/update-config.py
            printf "${blue}Running Configuration again...${nc}"
            cd /opt/Veil/config && ./update-config.py
            printf "${green}Done.${nc} \nRunning installation again."
            cd /opt/Veil && ./Veil.py --setup
            prinf " -- ${green}Complete${nc}\nVeil has been successfully re-configured and re-installed!"
            little_wget_magic # go to next phase
        else
            echo -e "${red} Terminating the script. ${blue} Superheroes need help too. :) ${nc}"
            exit -1
            # user choose to terminate the script.
            # no new function will be called from here.
        fi
    fi
}


#----------------------------------------
#SMBExec Installation!
#----------------------------------------
function SMBExec() {
    echo -e "
    ${yellow}#####################################
    ${blue}2) Installing SMBExec
    ${nc}SMBExec will be used to grab hashes out of Domain Controller and reverse shells
    "
    SMBExec_directory=/opt/smbexec
    if [ ! -d ${SMBExec_directory} ];then
        # install SMBExec
        cd /opt/ && git clone https://github.com/brav0hax/smbexec.git
        chmod a+x /opt/smbexec/install.sh
        echo -e "I am going to run the ${blue}install.sh script of SMBExec.${nc}
        You will need to ${blue}choose Option 1 for step 1.${nc}
        Then Choose your ${blue}current directory location (/opt/)${nc} by hitting ENTER key.
        Finally Choose ${blue}number 4${nc}(for unknown/if needed request)"
#        cd /opt/smbexec && ./install.sh
        echo -e "${green}Hopefully you have successfully installed SMBExec. It's a bit tricky. Take help from the book, if needed. ${nc}"
        Veil
    else
        # directory exists.
        echo -e "A folder named ${red}SMBExec already exist!${nc} Choose your options:
        1) SMBExec is already installed. ${green}Move on!${nc}
        2) ${red}Remove the SMBExec folder,${nc} Re-clone and Install fresh
        3) Do not Remove SMBExec. ${blue}Re-install again${nc}
        4) I need to figure this out. ${red}Stop this script${nc}"
        read -p "Please Choose between [1,2,3]" user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
            Veil # go to SMBExec to execute from there.
        elif (($user_option == 2));then
            echo -e "Removing ${red}OLD SMBExec${nc} and cloning again from github"
            rm -rf /opt/smbexec/
            cd /opt/ && git clone https://github.com/brav0hax/smbexec.git
            echo -e "Successfully cloned from Github. Running ${blue}install.sh script. ${nc} This may take a while"
            chmod a+x  /opt/smbexec/install.sh
#            cd /opt/smbexec && ./install.sh
            printf "Installing SMBExec -- ${green}DONE${nc}\n"
            Veil # go to Veil. SMBExec is done.
        elif (($user_option == 3));then
            printf "Installing SMBExec again.. "
            chmod a+x  /opt/smbexec/install.sh
#            cd /opt/smbexec && ./install.sh
            printf "${green}Done.${nc}\n"
            Veil # go to Veil. SMBExec is done.
        else
            echo -e "${red} Terminating the script. ${blue} Superheroes need help too. :) ${nc}"
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
    echo -e "
    ${blue} Installing Discover Scripts.${nc} [Originally called Backtrack - Scripts
    Discover is used for Passive Enumeration!"

    discover_directory=/opt/discover
    if [ ! -d ${discover_directory} ];then
        #    discover clone and install
        cd /opt/ && git clone https://github.com/leebaird/discover.git
        echo -e "
        ${green} Successfully ${nc} cloned from Github. Running update.sh script. This may take a while"
#         TODO: UNCOMMENT the following TWO LINE for production
#        chmod a+x /opt/discover/update.sh
#        cd /opt/discover && ./update.sh
        echo -e "Updating Discover -- ${green} DONE$ {nc}"
        SMBExec # go to SMBExec. Discover is done.
    else
        #   discover folder already exist.
        echo ""
        echo -e "${red} A folder named discover already exist! ${nc} Choose your options:
        1) Discover is already installed. ${green}Move on!${nc}
        2) ${red}Remove the Discover folder${nc}, Re-clone and Install
        3) Do not Remove Discover. ${blue} Run the ${green}update script again${nc}
        4) I need to figure this out. ${red}Stop this script${nc}"
        read -p "Choose option.. [1,2,3,4] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green} Moving on... ${nc}"
            SMBExec # go to SMBExec to execute from there.
        elif (($user_option == 2));then
            echo -e "Removing ${blue} OLD discover ${nc} and cloning again from github"
            rm -rf /opt/discover/
            cd /opt/ && git clone https://github.com/leebaird/discover.git
            echo -e "${green} Successfully ${nc} cloned from Github. Running update.sh script. This may take a while"
            chmod a+x /opt/discover/update.sh
            cd /opt/discover && ./update.sh
             echo -e "${blue} Updating Discover -- ${green} DONE ${nc}"
            SMBExec # go to SMBExec. Discover is done.
        elif (($user_option == 3));then
            echo -e "Running ${blue} update.sh script. ${nc} This may take a while"
            chmod a+x /opt/discover/update.sh
            cd /opt/discover && ./update.sh
            echo -e "${blue} Updating Discover -- ${green} DONE ${nc}"
            SMBExec # go to SMBExec. Discover is done.
        else
            echo -e "${red} Terminating the script. ${blue} Superheroes need help too. :) ${nc}"
            exit -1
            # user choose to terminate the script.
            # no new function will be called from here.
        fi
    fi
}


discover #discover will be called first.
#In order to keep the flow intact discover will call the later functions accordingly