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
say "--------------------------------------------------------------------------"
say "Envoi de mails (Serveur SMTP) :"
say "-------------------------------"
say "Nom de l'hôte (depuis le php) : "
say "wpsmtp ",:green
say "avec authentification par mot de passe"
say "Port : "
say "25", :green
say "Login : "
say "noreply@#{@domain}", :green
say "Mot de passe : "
say "#{@noreply_pass_smtp}", :green
say "--------------------------------------------------------------------------", :blue