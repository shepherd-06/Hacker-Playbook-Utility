#!/usr/bin/env bash
green='\033[0;32m'

exit 200 # TODO: remove/comment this line.

##TODO: need some design here
echo "Running the update command"
sudo apt update
#TODO: need some design here
echo "update complete"
#TODO: need some design here
echo "Running Upgrade"
#TODO: need some design here | user confirmation is needed here.
sudo apt upgrade
#TODO: need some design here
echo "Upgrade Complete"