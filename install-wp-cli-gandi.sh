#!/bin/bash
#
# verifie et/ou installe WP-CLI sur une instance Simple Hosting de chez Gandi.net 
# 
# Version 0.3
#
#
#

#  ===============
#  = Fancy Stuff (thank @maximebj for the idea) =
#  ===============
# Stop on error
set -e

# colorize and formatting command line
green='\x1B[0;32m'
cyan='\x1B[1;36m'
blue='\x1B[0;34m'
grey='\x1B[1;30m'
red='\x1B[0;31m'
bold='\033[1m'
normal='\033[0m'

# Jump a line
function line {
  echo " "
}

# bot has something to say
function bot {
  echo -e "${blue}${bold}$1 ${normal}"
}


##############
############################
#########

cd $HOME
SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"

# cd $SCRIPT_PATH
bot "je travail dans $(pwd)" && pwd
bot "je verifie que le dossier wp-cli existe"
if [ ! -d wp-cli ]; then 
   mkdir wp-cli
   echo "dossier crée"
else
   line
   bot "ok il existait déjà"
fi

cd $SCRIPT_PATH/wp-cli

bot "je travail dans $(pwd)" && pwd
bot "je verifie que le dossier wp-cli/bin existe"
if [ ! -d bin ]; then 
   mkdir bin
   echo "dossier crée"
else
   bot "ok il existait déjà"
fi

line
bot "je travail dans $(pwd)" && pwd
bot "est-ce que l'archive wp-cli est déjà present ?"

if [ ! -f wp-cli.phar ]; then 
   bot "pas trouvé, recupération de la dernieres archive depuis github"
   curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
else
   bot "archive wp-cli déjà present"
fi

cd $SCRIPT_PATH/wp-cli/bin
if [ ! -f wp ]; then 
   cp $SCRIPT_PATH/wp-cli/wp-cli.phar $SCRIPT_PATH/wp-cli/bin/wp
   chmod +x $SCRIPT_PATH/wp-cli/bin/wp
fi

cd $SCRIPT_PATH/wp-cli/
if [ ! -f wp-completion.bash ]; then
   bot "je travail dans " && pwd
   bot "je ne vois pas le fichier pour autocompletion, j'en profite pour le charger depuis github"
   curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash
else
   bot "archive wp-completion.bash déjà present"
fi
chmod +x wp-completion.bash

echo 'export PATH=$PATH:/home/hosting-user/wp-cli/bin/' >> ~/.profile_wp-cli
echo 'source /home/hosting-user/wp-cli/wp-completion.bash' >> ~/.profile_wp-cli

echo 'source ~/.profile_wp-cli' >> /srv/data/etc/bash/bashrc 
cd $HOME
source .profile

bot "voici ce que j'ai à propos de wp-cli :"
wp cli info
