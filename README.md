# wp-cli-gandi
installation de wp-cli sur une instance Simple Hosting de chez Gandi.net

## Simple Hosting et WP-CLI
De base il n'est pas possible d'installer WP-cli en tant qu'executable.
N'étant pas root sur votre instance Simple Hosting il n'est pas possible d'utiliser la commande 'sudo mv wp-cli.phar /usr/local/bin/wp'

Il est néanmoins possible d'utiliser la commande 'php wp-cli.phar' à la place.

Ce script à pour objectif de permettre d'utiliser directement la commande 'wp' utilisé par défaut dans tous les exemples officiels et dans la majorités des scripts tiers déjà dévelloppé.
De plus il sera egalement possible d'utiliser l'auto-complétion nativement dans la console.

