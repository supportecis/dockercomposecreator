# Docker Compose Creator

Création de docker-compose depuis templates, grâce à une image __ruby:alpine__

## Appel de l'image

Par défault, l'aide de la commande `generate` est affichée

    docker run -rm -it -v /root/compose:/output registry.teikhos.eu/misc/dcc:latest
    
### Aide

    docker run -rm -it -v /root/compose:/output registry.teikhos.eu/misc/dcc:latest help generate
    docker run -rm -it -v /root/compose:/output registry.teikhos.eu/misc/dcc:latest help list

### Lister des templates
    
    docker run -rm -v /root/compose:/output registry.teikhos.eu/misc/dcc:latest list v1
    docker run -rm -v /root/compose:/output registry.teikhos.eu/misc/dcc:latest list v2

### Générer un template    

Des options sont disponibles pour éviter les questions en ligne de commande, elles sont documentées dans l'aide.

    docker run -rm -v /root/compose:/output registry.teikhos.eu/misc/dcc:latest generate version projet environnement

## Aide à la création de templates


### Structure

Dans le dossier `templates` :

* le premier niveau est le tag correspond à la version
* le deuxième niveau est le nom du template à utiliser
* le troisième niveau est le tag correspondant à l'environnement

### Fichiers

#### Fichiers Erb

Tous les fichiers `.erb` seront traités et copiés comme des templates dans le dossier de destnation. Dans ces fichiers, vous appelez les variables avec la synthaxe suivante :  
`<%= @mavariable %>`

#### Fichier readme.rb

Si il y a un fichier `readme.rb` dans le répertoire du template, il sera exécuté automatiquement à la fin du traitement (attention, c'est un fichier Ruby, la syntaxe doit être correcte). Ce fichier ne devrait être utilisé que pour de l'affichage écran en sortie console.  
Vous pouvez utiliser les variblaes `@variable` ainsi que la fonction `say "mon texte", :macouleur` . Si "mon texte" se termine par un espace ("mon texte ") , il n'y a pas de retour chariot

    say "--------------------------------------------------------------------------", :blue
    say "Copier / Coller ces informations dans le ticket de support si nécessaire :", :blue
    say "--------------------------------------------------------------------------", :blue
    say "Base de données :"
    say "-----------------"
    say "Nom de l'hôte (depuis le php) : "
    say "wpdb", :green
    say "Nom de la base de données : " 
    say "wordpress", :green
    say "Utilisateur : "
    say "wordpress", :green
    say "Mot de passe : "
    say @user_pass_db, :green

### Variables disponibles

Vous pouvez utiliser pour les templates les variables suivantes :

`@clientname` = le nom du client, teikhos

`@machine` = le code de la machine, production01

`@project` = le nom du projet, example

`@domain` = le domaine final, example.com

`@fulldomain` = le domaine complet, qui sera le nom du dossier complet, www.example.com

`@root_pass_db` = le mot de passe généré aléatoirement pour le root de la base de données

`@user_pass_db` = le mot de passe généré aléatoirement pour le user de la base de données

`@noreply_pass_smtp` = le mot de passe généré aléatoirement pour noreply@example.com

`@backup_pass_smtp` = le mot de passe généré aléatoirement pour backupdb@example.com
