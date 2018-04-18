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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${nc}"

#--------------------------------------------------------------------
#Discover -> parameter val 1
#SMBExec -> param val 2
#Veil -> Param 3
#PeepingTom -> param 4
#EyeWitness -> param 5
#PowerSploit -> param 6
#Responder -> param 7
#Social Engineering Toolkit (SET) -> param 8
#Fuzzling Lists (SecLists) -> param 9
#--------------------------------------------------------------------
function filePath() {
    if (( ${1} == 1 ));then
        #discover
        echo /opt/discover
    elif (( ${1} == 2 )); then
        #SMBExec
        echo /opt/smbexec
    elif (( ${1} == 3 )); then
        #Veil
        echo /opt/Veil
    elif (( ${1} == 4 )); then
        # Peeping Tom
        echo /opt/peepingtom
    elif (( ${1} == 5 )); then
        # Eye Witness
        echo /opt/EyeWitness
    elif (( ${1} == 6 )); then
        # PowerSploit
        echo /opt/PowerSploit
    elif (( ${1} == 7 )); then
        #Responder
        echo /opt/Responder
    elif (( ${1} == 8 )); then
        # Social Engineering ToolKit (SET)
        echo /opt/set
    elif (( ${1} == 9 )); then
        # Fuzzing Lists (SecLists)
        echo /opt/SecLists
    else
        # Invalid Parameter
        exit
    fi
}

#--------------------------------------------------------------------
# Parameter 1) script/filename. ${1}
# Parameter 2) filePath ${2}
# Parameter 3) url ${3}
# Parameter 4) extra message {during installation period}
# Parameter 5) Short name (For mentioning phases)
# Other files and installation will be done from the calling function.
#--------------------------------------------------------------------
function clone_script() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing ${1}
    ${cyan}${4}
    ${yellow}#####################################${nc}
    "
    local directory=$(filePath ${2})

    if [ ! -d ${directory} ];then
        # install the script
        cd /opt/ && git clone ${3}
        echo -e "${green}${5} installation is complete${nc}"
    else
        # directory exists.
        echo -e "A folder named ${red}${5} already exist!${nc} Choose your options:
        1) ${5} is already installed. ${green}Move on!${nc}
        2) ${red}Remove the ${5} ${nc}Install fresh"
        read -p "Please Choose between [1,2] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
        else
            echo -e "Removing ${red}OLD ${5}${nc}"
            rm -rf ${directory}
            # installing fresh
            cd /opt/ && git clone ${3}
            echo -e "${green}${5} installation is complete${nc}"
        fi
    fi
}






#exit 255
#----------------------------------------
#Installing Beef and Fuzzing List--------
#----------------------------------------
function beef_fuzzing() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing BeEF
    ${nc}BeFF will be used as an cross-site scripting attack framework
    "
    #TODO: will install beef later
    #TODO: beef requires Ruby2.3 to run.
    #TODO: clone and install beef cloning their github page


    echo -e "
    ${yellow}#####################################
    ${blue}Installing Fuzzling Lists (SecLists)
    ${nc}These are scripts to use with Burp to Fuzz Parameters
    "
    fuzzDir=/opt/SecLists
    if [ ! -d ${fuzzDir} ];then
        # install Fuzzing Lists
        cd /opt/ && git clone http://github.com/danielmiessler/SecLists.git
        echo -e "${green}Fuzzing Lists installation is complete${nc}"
    else
        # directory exists.
        echo -e "A folder named ${red}SecLists already exist!${nc} Choose your options:
        1) Fuzzing Lists (SecLists) is already installed. ${green}Move on!${nc}
        2) ${red}Remove the SecLists folder,${nc}Install fresh"
        read -p "Please Choose between [1,2] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
        else
            echo -e "Removing ${red}OLD SecLists${nc}"
            rm -rf /opt/SecLists/
            # install fuzzing lists
            cd /opt/ && git clone http://github.com/danielmiessler/SecLists.git
            echo -e "${green}Fuzzing Lists installation is complete${nc}"
        fi
    fi
}

#----------------------------------------
#Installing bypassUAC--------------------
#TODO: Need Metepreter. Test and write in KALI
#----------------------------------------
function bypassUAC() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing bypassuac
    ${nc}will be used to bypass UAC in post exploitation.
    "
    beef_fuzzing
}

#----------------------------------------
#Installing Social Engineering Toolkit---
#----------------------------------------
function social_engineering_toolkit() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing Social Engineering Toolkit [SET]
    ${nc}SET will be used for Social Engineering Campagin
    "
    setDir=/opt/set
    if [ ! -d ${setDir} ];then
        # install set
        cd /opt/ && git clone http://github.com/trustedsec/social-engineer-toolkit/ set/
        cd /opt/set/ && chmod a+x setup.py
        cd /opt/set/ && python setup.py install
        echo -e "${green}SET installation is complete${nc}"
    else
        # directory exists.
        echo -e "A folder named ${red}SET already exist!${nc} Choose your options:
        1) SET is already installed. ${green}Move on!${nc}
        2) ${red}Remove the SET folder,${nc}Install fresh"
        read -p "Please Choose between [1,2] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
        else
            echo -e "Removing ${red}OLD SET${nc}"
            rm -rf /opt/set/
            # install set
            cd /opt/ && git clone http://github.com/trustedsec/social-engineer-toolkit/ set/
            cd /opt/set/ && chmod a+x setup.py
            cd /opt/set/ && python setup.py install
            echo -e "${green}SET installation is complete${nc}"
        fi
    fi
    bypassUAC
}


#----------------------------------------
#Installing PowerSploit
#----------------------------------------
function responder() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing Responder
    ${nc}Responder will be used to gain NTLM challenge/response hashes
    "
    responderDir=/opt/Responder
    if [ ! -d ${responderDir} ];then
        # install Responder
        cd /opt/ && git clone http://github.com/SpiderLabs/Responder.git
        echo -e "${green}Responder installation is complete${nc}"
    else
        # directory exists.
        echo -e "A folder named ${red}Responder already exist!${nc} Choose your options:
        1) Responder is already installed. ${green}Move on!${nc}
        2) ${red}Remove the Responder folder,${nc}Install fresh"
        read -p "Please Choose between [1,2] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
        else
            echo -e "Removing ${red}OLD Responder${nc}"
            rm -rf /opt/Responder/
            # install Responder
            cd /opt/ && git clone http://github.com/SpiderLabs/Responder.git
            echo -e "${green}Responder installation is complete${nc}"
        fi
    fi
    social_engineering_toolkit
}



#----------------------------------------
#Installing PowerSploit
#----------------------------------------
function powersploit() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing PowerSploit
    ${nc}PowerSploit are PowerShell scripts for post exploitation
    "
    PowerSploitDir=/opt/PowerSploit
    if [ ! -d ${PowerSploitDir} ];then
        # install PowerSploit
        cd /opt/ && git clone http://github.com/mattifestation/PowerSploit.git
        cd /opt/PowerSploit/ && wget http://raw.github.com/obscuresec/random/master/StartListener.py
        cd /opt/PowerSploit/ && wget http://raw.github.com/darkoperator/powershell_scripts/master/ps_encoder.py
        echo -e "${green}PowerSploit installation is complete${nc}"
    else
        # directory exists.
        echo -e "A folder named ${red}PowerSploit already exist!${nc} Choose your options:
        1) PowerSploit is already installed. ${green}Move on!${nc}
        2) ${red}Remove the PowerSploit folder,${nc}Install fresh"
        read -p "Please Choose between [1,2] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
        else
            echo -e "Removing ${red}OLD PowerSploit${nc}"
            rm -rf /opt/PowerSploit/
            # install PowerSploit
            cd /opt/ && git clone http://github.com/mattifestation/PowerSploit.git
            cd /opt/PowerSploit/ && wget http://raw.github.com/obscuresec/random/master/StartListener.py
            cd /opt/PowerSploit/ && wget http://raw.github.com/darkoperator/powershell_scripts/master/ps_encoder.py
            echo -e "${green}PowerSploit installation is complete${nc}"
        fi
    fi
    responder
}

#----------------------------------------
#Installing NMap Script
#----------------------------------------
function nmap_script() {
    echo -e "
    ${yellow}#####################################
    ${blue}Downloading Banner Plus Script
    ${nc}Banner Plus Script will be used for quicker scanning and smarter identification.
    "
    cd /usr/share/nmap/scripts/ && wget http://raw.github.com/hdm/scan-tools/master/nse/banner-plus.nse
    return
}


#----------------------------------------
#Peeping Tom
#----------------------------------------
function install_peeping_tom() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing Peeping Tom
    ${nc}PeepingTom will be used to take snapshots of Webpages
    "
    PeepingTomDir=/opt/peepingtom
    if [ ! -d ${PeepingTomDir} ];then
        # install PeepingTom
        cd /opt/ && git clone http://bitbucket.org/LaNMaSteR53/peepingtom.git
        cd /opt/peepingtom && wget http://gist.github.com/nopslider/5984316/raw/423b02c53d225fe8dfb4e2df9a20bc800cc78e2c/gnmap.pl

        if (($(getconf LONG_BIT) == 64));then
            cd /opt/peepingtom && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
            tar xvjf /opt/peepingtom/phantomjs-2.1.1-linux-x86_64.tar.bz2
            chmod a+x /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py
            python /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py
        else
            cd /opt/peepingtom && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-i686.tar.bz2
            tar xvjf /opt/peepingtom/phantomjs-2.1.1-linux-i686.tar.bz2
            chmod a+x /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py
            python /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py
        fi

        echo -e "${green}Peeping Tom installation is complete${nc}"
    else
        # directory exists.
        echo -e "A folder named ${red}PeepingTom already exist!${nc} Choose your options:
        1) PeepingTom is already installed. ${green}Move on!${nc}
        2) ${red}Remove the PeepingTom folder,${nc}Install fresh"
        read -p "Please Choose between [1,2] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
            return #return to the calling function
        else
            echo -e "Removing ${red}OLD PeepingTom${nc}"
            rm -rf /opt/peepingtom/
            # install PeepingTom
            cd /opt/ && git clone http://bitbucket.org/LaNMaSteR53/peepingtom.git
            cd /opt/peepingtom && wget http://gist.github.com/nopslider/5984316/raw/423b02c53d225fe8dfb4e2df9a20bc800cc78e2c/gnmap.pl

            if (($(getconf LONG_BIT) == 64));then
                cd /opt/peepingtom && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
                tar xvjf /opt/peepingtom/phantomjs-2.1.1-linux-x86_64.tar.bz2
                chmod a+x /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py
                python /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py
            else
                cd /opt/peepingtom && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-i686.tar.bz2
                tar xvjf /opt/peepingtom/phantomjs-2.1.1-linux-i686.tar.bz2
                chmod a+x /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py
                python /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py
            fi
            echo -e "${green}Peeping Tom installation is complete"
        fi
    fi
}

#----------------------------------------
#Eye Witness
#----------------------------------------
function install_eye_witness() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing Eye Witness
    ${nc}Eye Witness will be used to take snapshots of Webpages
    "
    EyeWitnessDir=/opt/EyeWitness
    if [ ! -d ${EyeWitnessDir} ];then
        # install EyeWitness
        cd /opt/ && git clone https://github.com/ChrisTruncer/EyeWitness.git
        chmod a+x /opt/EyeWitness/setup/setup.sh
        cd /opt/EyeWitness/setup && ./setup.sh
        echo -e "${green}Peeping Tom installation is complete${nc}"
    else
        # directory exists.
        echo -e "A folder named ${red}EyeWitness already exist!${nc} Choose your options:
        1) EyeWitness is already installed. ${green}Move on!${nc}
        2) ${red}Remove the EyeWitness folder,${nc}Install fresh"
        read -p "Please Choose between [1,2] : " user_option
        echo ""
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
            return #return to the calling function
        else
            echo -e "Removing ${red}OLD EyeWitness${nc}"
            rm -rf /opt/EyeWitness/
            # install EyeWitness
            cd /opt/ && git clone https://github.com/ChrisTruncer/EyeWitness.git
            chmod a+x /opt/EyeWitness/setup/setup.sh
            cd /opt/EyeWitness/setup && ./setup.sh
            echo -e "${green}Eye Witness installation is complete${nc}"
        fi
    fi
}

#----------------------------------------
#Peeping Tom or Eye Witness
#----------------------------------------
function peeping_tom_issue() {
    echo -e "${red}########### CAUTION ########### Peeping Tom is no Longer supported from ${nc}July 01, 2016${red} due to the success of ${yellow}Eye Witness${nc}
    ${blue}1) Would you like to continue installing Peeping Tom?${nc}
    ${blue}2) Would you like to install Eye Witness instead?${nc}
    ${blue}3) Would you like to install both?${nc}
    ${green}Both Peeping Tom and Eye Witness does the same job, Eye Witness just does it better. ${yellow} According to Tim Tomes (Creator of Peeping Tom)${nc}"
    read -n1 -p "Please Choose between [1,2,3] : " user_choice

    if (($user_choice == 1));then
        echo -e "${red}CAUTION ${nc} You are installing PeepingTom which is out of support for a long time."
        peeping_tom_issue
    elif (($user_choice == 2));then
        echo -e "Installing ${cyan}Eye Witness${nc}"
        install_eye_witness
    else
        echo -e "Installing BOTH ${cyan}Eye Witness${nc} and ${cyan}Peeping Tom.${red}You really should not play around with OLD tools${nc}"
        install_peeping_tom
        install_eye_witness
    fi
    nmap_script
}


#----------------------------------------
#Downloading Different files using WGET
#----------------------------------------
function little_wget_magic() {
    echo -e "${yellow}-------------------------------
    ${blue} Running a little WGET magic to download ${cyan}WCE (Windows Credential Editor), Mimikatz, Custom Password Lists, PeepingTom, NMap Script, PowerSploit, Responder, SET (Social Engineering Toolkit), BypassUAC and Fuzzing Lists.
    ${blue} This list is so f**king long, I know....
    ${yellow}-------------------------------${nc}"

    backup_directory=~/backup_wget

    # ---------------------------------------------------------
    # WCE
    # ---------------------------------------------------------
    echo -e "${blue} Download WCE (Windows Credential Editor) ${nc}.
    Windows Credential Editor will be used to pull password from memory."
    cd ~/Desktop/ && wget http://www.ampliasecurity.com/research/wce_v1_41beta_universal.zip
    unzip -d ~/Desktop/wce wce_v1_41beta_universal.zip
    if [ ! -d ${backup_directory} ];then
        mkdir ~/backup_wget
    fi
    mv ~/Desktop/wce_v1_41beta_universal.zip ~/backup_wget/
    echo -e "${green}WCE is downloaded and unzipped in ~/Desktop/wce. zipped backup is kept in ~/backup_wget/ directory${nc}"


    # ---------------------------------------------------------
    #Mimikatz
    # ---------------------------------------------------------
    echo -e "${blue} Download Mimikatz ${nc}.
    Mimikatz will be used to pull password from memory."
    cd ~/Desktop/ && wget http://blog.gentilkiwi.com/downloads/mimikatz_trunk.zip
    unzip -d ~/Desktop/mimikatz mimikatz_trunk.zip
    if [ ! -d ${backup_directory} ];then
        mkdir ~/backup_wget
    fi
    mv ~/Desktop/mimikatz_trunk.zip ~/backup_wget/
    echo -e "${green}Mimikatz is downloaded and unzipped. A backup is kept as well.${nc}"


    # ---------------------------------------------------------
    # --------- Custom Password list ---------
    # Skill Security
    # ---------------------------------------------------------

    custom_password_directory=~/Desktop/password_list/
    custom_password_bk=~/backup_wget/password_list/
    echo -e "${blue}Download Custom Password list.${nc}
    First. Rock you of Skull Security"
    if [ ! -d ${custom_password_directory} ];then
        mkdir ~/Desktop/password_list/
    fi
    cd ~/Desktop/password_list && wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
    bzip2 ~/Desktop/password_list/rockyou.txt.bz2
    if [ ! -d ${custom_password_bk} ];then
        mkdir ~/backup_wget/password_list/
    fi
    mv ~/Desktop/password_list/rockyou.txt.bz2 ~/backup_wget/password_list/


    # ---------------------------------------------------------
    # ---------------------------------------------------------
    # CrackStation Portion.
    # ---------------------------------------------------------
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
            echo -e "${green}I am guessing Transmission is downloading the crackstation's file. Moving on... ${nc}"
        else
            echo -e "${red}Transmission is not installed or not found.${nc} Do you want to download it via ${green}1) HTTP Mirror ${nc} or 2) you will do it by yourself?"
            read -n1 -p "Please Choose between [1,2] : " user_option
            if (( $user_option == 1));then
                echo -e  "${green} Downloading Crackstation password list via HTTP Mirror. ${nc}"
                if [ ! -d ${custom_password_directory} ];then
                    mkdir ~/Desktop/password_list/
                fi
                cd ~/Desktop/password_list/ && wget https://crackstation.net/files/crackstation-human-only.txt.gz
                gzip ~/Desktop/password_list/crackstation-human-only.txt.gz
                mv ~/Desktop/password_list/crackstation-human-only.txt.gz ~/backup_wget/password_list/
            else
                echo -e "${green}Moving on...... ${nc}"
            fi
        fi
    else
        echo -e "${green} Downloading Crackstation password list via HTTP Mirror. ${nc}"
        if [ ! -d ${custom_password_directory} ];then
            mkdir ~/Desktop/password_list/
        fi
        cd ~/Desktop/password_list/ && wget https://crackstation.net/files/crackstation-human-only.txt.gz
        gzip ~/Desktop/password_list/crackstation-human-only.txt.gz
        mv ~/Desktop/password_list/crackstation-human-only.txt.gz ~/backup_wget/password_list/
    fi

    echo -e "${blue} CrackStation has a rather long (15 gigs uncompressed) password. Check them out on their website{$nc}"
    # ---------------------------------------------------------
    # ---------------------------------------------------------
    # ---------------------------------------------------------
    peeping_tom_issue # moving to peeping tom because it's going to take a while there.
    # peeping tom stop upgrading their repo because of Eye Witness.
}

#----------------------------------------
#Veil version 3.0 Installation!
#TODO: Need to check Veil from Kali------
#----------------------------------------
function Veil() {
    echo -e "${yellow}-------------------------------
    ${red} Veil Evasion is no Longer supported. ${cyan}Currently running Veil 3.0
    ${blue} Cloning from ${yellow} https://github.com/Veil-Framework/Veil
    ${blue} Would you like to continue?
    ${yellow}-------------------------------${nc}"

    read -n1 -p "Choose y for yes, n for no : " user_option
    echo ""
    if [ "$user_option" = "n" ] || [ "$user_option" = "N" ];then
        echo -e "${blue}Proceeding Forward$ :)${nc}"
        sleep 3s
        little_wget_magic
    fi

    script_name="Veil"
    extra_message="Veil will be used to create Python based Meterpreter executable"
    short_name="Veil"

    #calling clone script with addition parameters
    clone_script "${script_name}" 3 https://github.com/Veil-Framework/Veil "${extra_message} ${short_name}"

    printf "${green}Successfully cloned Veil.${nc} Updating Configuration now..."
    cd /opt/Veil/config && ./update-config.py
    printf "${green}Done.\n${nc}Running installation now."
    cd /opt/Veil/ && ./Veil.py --setup
    prinf " -- ${green}Complete\n${nc}"

    sleep 2s
    little_wget_magic
}


#----------------------------------------
#SMBExec Installation!
#----------------------------------------
function SMBExec() {
    script_name="SMBExec"
    extra_message="SMBExec will be used to grab hashes out of Domain Controller and reverse shells"
    short_name="SMBExec"

    #calling clone script with addition parameters
    clone_script "${script_name}" 2 https://github.com/brav0hax/smbexec.git "${extra_message} ${short_name}"

    chmod a+x /opt/smbexec/install.sh
    echo -e "Follow the ${blue}book for Installation Procedure"
    cd /opt/smbexec && ./install.sh
    sleep 2s
    Veil
}


#----------------------------------------
#Discover Installation!
#----------------------------------------
function discover() {
    script_name="Discover Scripts (Formerly known as backtrack Scrpts)"
    extra_message="Discover is used for Passive Enumeration!"
    short_name="Discover"

    #calling clone script with addition parameters
    clone_script "${script_name}" 1 https://github.com/leebaird/discover.git "${extra_message} ${short_name}"

    chmod a+x /opt/discover/update.sh
    cd /opt/discover && ./update.sh
    echo -e "Installing ${short_name} -- ${green} DONE$ ${nc}"
    sleep 2s # Wait 2 seconds before Running SMBExec
    SMBExec
}


discover #discover will be called first.
#In order to keep the flow intact discover will call the later functions accordingly