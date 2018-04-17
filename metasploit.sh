#!/usr/bin/env bash
green="\033[0;32m"
red="\033[0;31m"
cyan="\033[0;36m"
nc="\033[0m"
blue="\033[1;34m"
yellow="\033[1;33m"
lightPurple='\033[1;35m'

echo -e "${cyan} Escaping Metasploit Installation phase${nc}"

exit 200

echo -e "${lightPurple}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~Checking Metasploit Status~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ${nc}"

which -a Metasploit
if [ $? -eq 1 ] #returns 0 if psql is installed.
then
    echo -e "${red}Metasploit Framework is not installed${nc}"
else
    echo "Metasploit is installed!"
fi
# step 5.c and 6 (a,b,c)
echo -e "${cyan}TODO: work on Metasploit must be done from the Kali machine or a VM machine.
Tue Apr 17 06:28:51 +06 2018 ${nc}"