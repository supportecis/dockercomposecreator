say "--------------------------------------------------------------------------", :blue
say "Copier / Coller ces informations dans le ticket de support si nécessaire :", :blue
say "--------------------------------------------------------------------------", :blue
say "Base de données :"
say "-----------------"
say "Nom de l'hôte (depuis le php) : "
say "sqldb", :green
say "Nom de la base de données : " 
say @project, :green
say "Utilisateur : "
say @project, :green
say "Mot de passe : "
say @user_pass_db, :green
say "--------------------------------------------------------------------------"
say "Envoi de mails (Serveur SMTP) :"
say "-------------------------------"
say "Nom de l'hôte (depuis le php) : "
say "smtp ",:green
say "avec authentification par mot de passe"
say "Port : "
say "25", :green
say "Login : "
say "noreply@#{@domain}", :green
say "Mot de passe : "
say "#{@noreply_pass_smtp}", :green
say "--------------------------------------------------------------------------", :blue
say "Exemple fichier #{@fulldomain}.yml  à intégrer dossiers vhosts du proxy apache :", :blue
say "--------------------------------------------------------------------------", :blue
say "version: \"1.0\""
say "vhost:"
say "  name: "+@fulldomain
say "  alias:"
say "    - "+@domain
say "    - #{@fulldomain}.#{@machine}.#{@clientname}.as49517.net"
say "protocols:"
say "  http: yes"
say "  https: no"
say "backend:"
say "  protocol: http"
say "  host: #{@fulldomain}.vhost"
say "  port: 80"
say "  preserve_host: yes"
say "--------------------------------------------------------------------------", :blue
