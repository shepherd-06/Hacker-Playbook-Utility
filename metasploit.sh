#!/usr/bin/env bash

which -a Metasploit
if [ $? -eq 1 ] #returns 0 if psql is installed.
then
    echo "Metasploit Framework is not installed"
else
    echo "Metasploit FM is installed!"
fi

echo "TODO: work on Metasploit must be done from the Kali machine or a VM machine.
Tue Apr 17 06:28:51 +06 2018"