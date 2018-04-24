#!/usr/bin/env bash

green="\033[0;32m"
red="\033[0;31m"
cyan="\033[0;36m"
nc="\033[0m"
blue="\033[1;34m"
yellow="\033[1;33m"
lightPurple='\033[1;35m'

echo -e "${lightPurple}
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Running Phase BRAVO Installation
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ${nc}"

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
# :param
# Parameter 1) script/filename. ${1}
# Parameter 2) filePath ${2}
# Parameter 3) url ${3}
# Parameter 4) extra message {during installation period}
# Parameter 5) Short name (For mentioning phases)
# Other files and installation will be done from the calling function.
# :return
# first install -> 0
# success (move on)[NO INSTALL] -> 10
# keep old, run the installation again -> 20
# rm old, fresh clone -> 30
#--------------------------------------------------------------------
function clone_script() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing ${1}
    ${cyan}${4}
    ${yellow}#####################################${nc}
    "
    local directory=$(filePath ${2})
    sleep 2s ## sleep sleep sleep
    if [ ! -d ${directory} ];then
        # install the script
        if (( ${2} == 8 )); then
            # Special Case
            # Social Engineering ToolKit (SET)
            cd /opt/ && git clone ${3} set/
            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "cd /opt/ && git clone ${3} set/"
                exit 255
            fi
        else
            cd /opt/ && git clone ${3}
            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "cd /opt/ && git clone ${3}"
                exit 255
            fi
        fi
        echo -e "${green}${5} installation is complete${nc}"
        sleep 2s ## sleep sleep sleep

        return 0 ## fresh first install
    else
        # directory exists.
        echo -e "A folder named ${red}${5} already exist!${nc} Choose your options:
        1) ${5} is already installed. ${green}Move on!${nc}
        2) Run ${5} installation again.
        3) ${red}Remove the ${5} ${nc}Clone again..
        "
        read -n1 -p "Please Choose between [1,2,3] : " user_option
        echo ""
        sleep 2s ## sleep sleep sleep
        if (($user_option == 1 ));then
            echo -e "${green}Moving on...${nc}"
            sleep 2s ## sleep sleep sleep
            return 10 # green green. nothing to do.
        elif (($user_option == 2));then
            return 20 ## running installation
        else
            echo -e "Removing ${red}OLD ${5}${nc}"
            rm -rf ${directory}
            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "rm -rf ${directory}"
                exit 255
            fi
            # installing fresh
            cd /opt/ && git clone ${3}
            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "cd /opt/ && git clone ${3}"
                exit 255
            fi
            sleep 2s ## sleep sleep sleep
            return 30 ## cloned fresh, need to run installation again!
        fi
    fi
}


function end_message() {
    #################################
    #### END MESSAGE ################
    #################################
    echo -e "${lightPurple}
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~That's It!! Happy coding :)~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ${nc}"
    sleep 2s ## sleep sleep sleep
}


#----------------------------------------
#TODO: crackstation need much error logging I guess.
#Downloading Different files using WGET
#----------------------------------------
function little_wget_magic() {
    echo -e "${yellow}-------------------------------
    ${blue} Running a little WGET magic to download ${cyan}WCE (Windows Credential Editor), Mimikatz, Custom Password Lists, PeepingTom, NMap Script, PowerSploit, Responder, SET (Social Engineering Toolkit), BypassUAC and Fuzzing Lists.
    ${blue} This list is so f**king long, I know....
    ${yellow}-------------------------------${nc}"

    backup_directory=~/backup_wget
    sleep 5s #### why NOT!

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
    sleep 2s


    # ---------------------------------------------------------
    #Mimikatz
    # ---------------------------------------------------------
    echo -e "
    ${yellow}-------------------------------${nc}
    ${blue} Download Mimikatz ${nc}.
    Mimikatz will be used to pull password from memory.
    ${yellow}-------------------------------${nc}"
    cd ~/Desktop/ && wget http://blog.gentilkiwi.com/downloads/mimikatz_trunk.zip
    unzip -d ~/Desktop/mimikatz mimikatz_trunk.zip
    if [ ! -d ${backup_directory} ];then
        mkdir ~/backup_wget
    fi
    mv ~/Desktop/mimikatz_trunk.zip ~/backup_wget/
    echo -e "${green}Mimikatz is downloaded and unzipped. A backup is kept as well.${nc}"
    sleep 2s

    # ---------------------------------------------------------
    # --------- Custom Password list ---------
    # Skill Security
    # ---------------------------------------------------------

    custom_password_directory=~/Desktop/password_list/
    custom_password_bk=~/backup_wget/password_list/
    echo -e "${yellow}-------------------------------${nc}
    ${blue}Download Custom Password list.${nc}
    First. Rock you of Skull Security
    {yellow}-------------------------------${nc}"
    if [ ! -d ${custom_password_directory} ];then
        mkdir ~/Desktop/password_list/
    fi
    cd ~/Desktop/password_list && wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
    bzip2 ~/Desktop/password_list/rockyou.txt.bz2
    if [ ! -d ${custom_password_bk} ];then
        mkdir ~/backup_wget/password_list/
    fi
    mv ~/Desktop/password_list/rockyou.txt.bz2 ~/backup_wget/password_list/
    sleep 2s

    # ---------------------------------------------------------
    # ---------------------------------------------------------
    # CrackStation Portion.
    # ---------------------------------------------------------
    echo -e "${green}Downloaded Rock you file of Skull Security${nc}
    ${yellow}-------------------------------${nc}
    ${blue}Downloading Human password list of CrackStation${nc}
    ${cyan}The list is free however, CrackStation has a donation page running for whatever amount you wish. If you feel, follow this url: ${yellow} https://crackstation.net/buy-crackstation-wordlist-password-cracking-dictionary.htm${nc}
    ${yellow}-------------------------------${nc}

    Do you want to Download ${blue}CrackStation password list ${nc} using Torrent or HTTP Mirror? It's a ${blue}247 MB${nc} of GZIP compressed file.
    ${blue}Choose 1, if you want Torrent (Fast).
    Choose 2, if you want to use HTTP Mirror (Bit Slower) ${nc}"

    read -n1 -p "Please Choose between [1,2] : " user_option
    if (($user_option == 1 ));then
        cd ~/Desktop/ && wget https://crackstation.net/downloads/crackstation-human-only.txt.gz.torrent
        which -a transmission-gtk
        if [ $? -eq 0 ];then
            transmission-gtk ~/Desktop/crackstation-human-only.txt.gz.torrent
            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "transmission-gtk ~/Desktop/crackstation-human-only.txt.gz.torrent"
                exit 255
            fi
            sleep 5s # sleep 5 seconds for this command to finish
            echo -e "${green}I am guessing Transmission is downloading the crackstation's file. Moving on... ${nc}"
        else
            echo -e "${red}Transmission is not installed or not found.${nc} Do you want to download it via ${green}1) HTTP Mirror ${nc} or 2) you will do it by yourself?"
            read -n1 -p "Please Choose between [1,2] : " user_option
            if (( $user_option == 1));then
                echo -e  "${green} Downloading Crackstation password list via HTTP Mirror. ${yellow}It'll be awhile.. ${nc}"
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
        echo -e "${green} Downloading Crackstation password list via HTTP Mirror. ${yellow}It'll be awhile.. ${nc}"
        if [ ! -d ${custom_password_directory} ];then
            mkdir ~/Desktop/password_list/
        fi
        cd ~/Desktop/password_list/ && wget https://crackstation.net/files/crackstation-human-only.txt.gz
        gzip ~/Desktop/password_list/crackstation-human-only.txt.gz
        mv ~/Desktop/password_list/crackstation-human-only.txt.gz ~/backup_wget/password_list/
    fi
    echo -e "${yellow}------------------------------------------
    ${blue} CrackStation has a rather long (15 gigs uncompressed) password. Check them out on their website
    ${yellow}------------------------------------------${nc}"
    sleep 5s

    # ---------------------------------------------------------
    # ---------------------------------------------------------
    # NMAP Scripts
    # ---------------------------------------------------------
    echo -e "
    ${yellow}#####################################
    ${blue}Downloading Banner Plus Script
    ${nc}Banner Plus Script will be used for quicker scanning and smarter identification.
    ${yellow}###################################### ${nc}
    "
    cd /usr/share/nmap/scripts/ && wget http://raw.github.com/hdm/scan-tools/master/nse/banner-plus.nse
    sleep 2s # wait b4 next shot.
    end_message # last function call
}



#----------------------------------------
#Fuzzing List----------------------------
#----------------------------------------
function fuzzing() {
    script_name="Fuzzing Lists (SecLists)"
    extra_message="SET will be used for Social Engineering Campagin"
    short_name="Fuzzing Lists"

    #calling clone script with addition parameters
    clone_script "${script_name}" 9 http://github.com/danielmiessler/SecLists.git "${extra_message}" "${short_name}"

    sleep 2s #almost there
    little_wget_magic # its a long wget call.
}

#exit 255
#----------------------------------------
#Installing Beef and Fuzzing List--------
#----------------------------------------
function beEF() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing BeEF
    ${nc}BeFF will be used as an cross-site scripting attack framework
    "
    #TODO: will install beef later
    #TODO: beef requires Ruby2.3 to run.
    #TODO: clone and install beef cloning their github page
    fuzzing
}
#----------------------------------------
#Installing bypassUAC--------------------
#TODO: Need Metepreter. Test and write in KALI
#----------------------------------------
function bypassUAC() {
    echo -e "
    ${yellow}#####################################
    ${blue}Installing bypassuac {Need MeteSploit framework}
    ${nc}will be used to bypass UAC in post exploitation.
    ${yellow}#####################################${nc}
    "
    beEF
}

#----------------------------------------
#Installing Social Engineering Toolkit---
#----------------------------------------
function social_engineering_toolkit() {
    script_name="Social Engineering Toolkit [SET]"
    extra_message="SET will be used for Social Engineering Campagin"
    short_name="SET"

    #calling clone script with addition parameters
    clone_script "${script_name}" 8 http://github.com/trustedsec/social-engineer-toolkit/ "${extra_message}" "${short_name}"

    status=$?
    ## install for 0, 20, 30
    ## no install for 10
    if (( ${status} == 0 )) || (( ${status} == 20 )) || (( ${status} == 30 ));then
        cd /opt/set/ && chmod a+x setup.py
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/set/ && chmod a+x setup.py"
            exit 255
        fi

        cd /opt/set/ && python setup.py install
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/set/ && python setup.py install"
            exit 255
        fi
    fi

    sleep 2s # sleeping 2s b4 doing anything else.
    bypassUAC
}


#----------------------------------------
#Installing PowerSploit
#----------------------------------------
function responder() {
    script_name="Responder"
    extra_message="Responder will be used to gain NTLM challenge/response hashes"
    short_name="Responder"

    #calling clone script with addition parameters
    clone_script "${script_name}" 7 http://github.com/SpiderLabs/Responder.git "${extra_message}" "${short_name}"

    sleep 2s #sleeping....
    social_engineering_toolkit
}



#----------------------------------------
#Installing PowerSploit
#----------------------------------------
function powersploit() {
    script_name="PowerSploit"
    extra_message="PowerSploit are PowerShell scripts for post exploitation"
    short_name="PowerSploit"

    #calling clone script with addition parameters
    clone_script "${script_name}" 6 http://github.com/mattifestation/PowerSploit.git "${extra_message}" "${short_name}"

    status=$?
    ## install for 0, 20, 30
    ## no install for 10
    if (( ${status} == 0 )) || (( ${status} == 20 )) || (( ${status} == 30 ));then
        cd /opt/PowerSploit/ && wget http://raw.github.com/obscuresec/random/master/StartListener.py
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/PowerSploit/ && wget http://raw.github.com/obscuresec/random/master/StartListener.py"
            exit 255
        fi
        cd /opt/PowerSploit/ && wget http://raw.github.com/darkoperator/powershell_scripts/master/ps_encoder.py
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/PowerSploit/ && wget http://raw.github.com/darkoperator/powershell_scripts/master/ps_encoder.py"
            exit 255
        fi
        echo -e "${green}${script_name} installation is complete${nc}"
    fi

    sleep 2s #wait 2seconds b4 doing anything stupid! :p
    responder
}

#----------------------------------------
#Peeping Tom
#----------------------------------------
function install_peeping_tom() {
    script_name="Peeping Tom"
    extra_message="PeepingTom will be used to take snapshots of Webpages"
    short_name="Peeping Tom"

    #calling clone script with addition parameters
    clone_script "${script_name}" 4 http://bitbucket.org/LaNMaSteR53/peepingtom.git "${extra_message}" "${short_name}"

    status=$?
    ## install for 0, 20, 30
    ## no install for 10
    if (( ${status} == 0 )) || (( ${status} == 20 )) || (( ${status} == 30 ));then
#        # install PeepingTom
#        cd /opt/ && git clone http://bitbucket.org/LaNMaSteR53/peepingtom.git
#
#        ## if the previous commit failed to run.
#        if [ $? -ne 0 ];then
#            ./terminator.sh 1 "cd /opt/ && git clone http://bitbucket.org/LaNMaSteR53/peepingtom.git"
#            exit 255
#        fi

        cd /opt/peepingtom && wget http://gist.github.com/nopslider/5984316/raw/423b02c53d225fe8dfb4e2df9a20bc800cc78e2c/gnmap.pl

        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/peepingtom && wget http://gist.github.com/nopslider/5984316/raw/423b02c53d225fe8dfb4e2df9a20bc800cc78e2c/gnmap.pl"
            exit 255
        fi

        if (($(getconf LONG_BIT) == 64));then
            cd /opt/peepingtom && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2

                ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "cd /opt/peepingtom && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2"
                exit 255
            fi

            tar xvjf /opt/peepingtom/phantomjs-2.1.1-linux-x86_64.tar.bz2

            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "tar xvjf /opt/peepingtom/phantomjs-2.1.1-linux-x86_64.tar.bz2"
                exit 255
            fi

            chmod a+x /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py

            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "chmod a+x /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py"
                exit 255
            fi

            python /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py

            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "python /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py"
                exit 255
            fi
        else
            cd /opt/peepingtom && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-i686.tar.bz2

            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "cd /opt/peepingtom && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-i686.tar.bz2"
                exit 255
            fi

            tar xvjf /opt/peepingtom/phantomjs-2.1.1-linux-i686.tar.bz2

            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "tar xvjf /opt/peepingtom/phantomjs-2.1.1-linux-i686.tar.bz2"
                exit 255
            fi

            chmod a+x /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py

            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "chmod a+x /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py"
                exit 255
            fi

            python /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py

            ## if the previous commit failed to run.
            if [ $? -ne 0 ];then
                ./terminator.sh 1 "python /opt/peepingtom/phantomjs-2.1.1-linux-x86_64/build.py"
                exit 255
            fi
        fi
        echo -e "${green}Peeping Tom installation is complete${nc}"
    fi

    sleep 2s # sleep 2s before doing anything else
    return 0
}

#----------------------------------------
#Eye Witness
#----------------------------------------
function install_eye_witness() {
    script_name="Eye Witness"
    extra_message="PeepingTom will be used to take snapshots of Webpages"
    short_name="Eye Witness"

    #calling clone script with addition parameters
    clone_script "${script_name}" 5 https://github.com/ChrisTruncer/EyeWitness.git "${extra_message}" "${short_name}"

    status=$?
    ## install for 0, 20, 30
    ## no install for 10
    if (( ${status} == 0 )) || (( ${status} == 20 )) || (( ${status} == 30 ));then
        chmod a+x /opt/EyeWitness/setup/setup.sh
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "chmod a+x /opt/EyeWitness/setup/setup.sh"
            exit 255
        fi

        cd /opt/EyeWitness/setup && ./setup.sh

        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/EyeWitness/setup && ./setup.sh"
            exit 255
        fi
        echo -e "${green}${script_name} installation is complete${nc}"
    fi

    sleep 2s # sleep 2s before doing anything else
    return 0
}

#----------------------------------------
#Peeping Tom or Eye Witness
#@caution: Peeping Tom is unsupported for over a year!
#----------------------------------------
function peeping_tom_issue() {
    echo -e "
    ${red}########### CAUTION ###########
     Peeping Tom is no Longer supported from ${nc}July 01, 2016${red} due to the success of ${cyan}Eye Witness${nc}
    ${blue}1) Would you like to continue installing Peeping Tom?${nc}
    ${blue}2) Would you like to install Eye Witness instead?${nc}
    ${blue}3) Would you like to install both?${nc}
    ${green}Both Peeping Tom and Eye Witness does the same job, Eye Witness just does it better. ${yellow} According to Tim Tomes (Creator of Peeping Tom)${nc}
    "

    read -n1 -p "Please Choose between [1,2,3] : " user_choice
    echo ""

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
    sleep 2s # sleep 2s before doing anything else
    powersploit
}


#----------------------------------------
#Veil version 3.0 Installation!
#----------------------------------------
function Veil() {
    echo -e "${yellow}Veil Evasion is no Longer supported, ${cyan}Installing Veil 3.0 instead. Cloning from ${blue} https://github.com/Veil-Framework/Veil${nc}"

#    Script will directly move to Install Veil 3.0, less clutter.
#    read -n1 -p "Choose y for yes, n for no : " user_option
#    echo ""
#    if [ "$user_option" == "n" ] || [ "$user_option" == "N" ];then
#        echo -e "${blue}Ignoring Veil. Moving Forward... :)${nc}"
#        sleep 3s
#        peeping_tom_issue
#    fi

    script_name="Veil"
    extra_message="Veil will be used to create Python based Meterpreter executable"
    short_name="Veil 3.0"
    #calling clone script with addition parameters
    clone_script "${script_name}" 3 https://github.com/Veil-Framework/Veil "${extra_message}" "${short_name}"

    status=$?
    ## install for 0, 20, 30
    ## no install for 10
    if (( ${status} == 0 )) || (( ${status} == 20 )) || (( ${status} == 30 ));then
        echo -e "${green}Successfully cloned Veil.${nc} Running Installation  now..."
        chmod a+x /opt/Veil/config/setup.sh
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "chmod a+x /opt/Veil/config/setup.sh"
            exit 255
        fi
        cd /opt/Veil/config && ./setup.sh --force --silent ##force overwrite everything, silent does not user attention (worth to take a look later)
        ## if the previous commit failed to run.

        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/Veil/config && ./setup.sh --force --silent"
            exit 255
        fi

        echo -e "If there's an ${red}error${nc}, do you want to ${blue} nuke the wine folder option?${nc}"
        echo ""
        sleep 1s
        read -n1 -p "Confirm [y/n] : " user_choice
        echo ""

        if [ "${user_choice}" == "Y" ] || [ "${user_choice}" == "y" ];then
            echo -e "${blue}Nuking the wine..${nc}"
            cd /opt/Veil/ && ./Veil.py --setup
        fi
        sleep 1s
        echo -e "${green}${short_name} Complete.${nc}"
    fi

    sleep 2s
    peeping_tom_issue
}


#----------------------------------------
#SMBExec Installation!
#----------------------------------------
function SMBExec() {
    script_name="SMBExec"
    extra_message="SMBExec will be used to grab hashes out of Domain Controller and reverse shells"
    short_name="SMBExec"

    #calling clone script with addition parameters
    clone_script "${script_name}" 2 https://github.com/brav0hax/smbexec.git "${extra_message}" "${short_name}"

    status=$?
    ## install for 0, 20, 30
    ## no install for 10
    if (( ${status} == 0 )) || (( ${status} == 20 )) || (( ${status} == 30 ));then
        chmod a+x /opt/smbexec/install.sh
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "chmod a+x /opt/smbexec/install.sh"
            exit 255
        fi
        echo -e "Follow the ${blue}book for Installation Procedure"

        cd /opt/smbexec && ./install.sh
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/smbexec && ./install.sh"
            exit 255
        fi
        echo -e "Installing ${short_name} -- ${green} DONE$ ${nc}"
    fi
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
    clone_script "${script_name}" 1 https://github.com/leebaird/discover.git "${extra_message}" "${short_name}"

    status=$?
    ## install for 0, 20, 30
    ## no install for 10

    if (( ${status} == 0 )) || (( ${status} == 20 )) || (( ${status} == 30 ));then
        #nothing to do
        chmod a+x /opt/discover/update.sh
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "chmod a+x /opt/discover/update.sh"
            exit 255
        fi

        cd /opt/discover && ./update.sh
        ## if the previous commit failed to run.
        if [ $? -ne 0 ];then
            ./terminator.sh 1 "cd /opt/discover && ./update.sh"
            exit 255
        fi
        echo -e "Installing ${short_name} -- ${green} DONE$ ${nc}"
    fi

    sleep 2s # Wait 2 seconds before Running SMBExec
    SMBExec
}


#---------------------------------------------------------------
#---------------------------------------------------------------
#---------------------------------------------------------------
#---------------------------------------------------------------
which -a msfconsole
if [ $? -eq 0 ];then
    ## Metasploit is isntalled.
    if [[ $EUID -ne 0 ]];then
        echo -e "${cyan}This script needs to run in super-user mode... ${nc}"
        sudo su # script will ask user for password to sudo mode.
    fi

    ## TODO: might need to check if postgreSQL is installed TOO.

    discover #Beginning of everything.
else
    echo -e "${red} Metasploit is not installed properly! or not found${blue} "$(which -a msfconsole)".${nc}Terminating script."
    sleep 3s ## boom boom
    ./terminator.sh 2 ""
fi



##TODO: Task at hand.
##Install or Write code for the following in Kali machine -> Veil, BypassUAC, BeEF {Important}
##might need to check if postgreSQL is installed TOO before calling discover.
##Need error checker in this script. {Placed} {Check if they actually work from Kali}
##PeepingTom has an issue in installation. Peeping tom has been installed b4hand.