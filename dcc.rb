#!/usr/bin/ruby
# encoding: utf-8

require 'thor'
require 'pawgen'
require 'fileutils'

class DockerComposeCreator < Thor
    include Thor::Shell
    include Thor::Actions
    
    OUTPUT_DIR = "/output"
    TEMPLATE_EXTNAME = ".erb"
    
    protected
    def self.source_root
        # le chemin des templates pour le projet
        File.join(Dir.pwd,"templates")
    end
    
    public 
    desc "list VERSION", "Liste les projets disponibles par version de compose"
    def list(sComposeVersion)         
        sFullPath = find_in_source_paths(sComposeVersion)
        say "---------------------------------", :blue
        say "Templates for docker-compose #{sComposeVersion} :", :blue
        say "---------------------------------", :blue
        Dir.foreach(sFullPath) {|sProjetDir|
            if sProjetDir != "." and sProjetDir != ".."
                sShowProjectWithEnv = ""
                sFullPathEnv = File.join(sFullPath,sProjetDir)
                Dir.foreach(sFullPathEnv) { |sEnv|
                    if sEnv != "." and sEnv != ".."
                        sShowProjectWithEnv = sShowProjectWithEnv+" #{sEnv}"    
                    end
                }
                say(sProjetDir+" ",:green)
                say("with envs : ")
                say(sShowProjectWithEnv,:green)
            end               
        }
    end
    
    desc "generate VERSION TEMPLATE ENVIRONNEMENT", "Génération d'un docker-compose.yml"
    long_desc <<-LONGDESC
      `generate` crée dans le dossier de sortie une structure basée sur le template envoyé en paramètre.      
      \x5
      Le dossier généré par cette fonction aura pour nom : "prefixe.nomduprojet.extension" 
    LONGDESC
    
    method_option :client, :type => :string, :desc => "Le nom du client (en minuscule, sans espaces ou caractères spéciaux)"
    method_option :machine, :type => :string, :desc => "Le nom de la machine (en minuscule, sans espaces ou caractères spéciaux)"
    method_option :projet, :type => :string, :desc => "Le nom du projet (sans le prefixe et l'extension)"
    method_option :prefixe, :type => :string, :desc => "Le préfixe, sans le point (www, auth, ...)"
    method_option :extension, :type => :string, :desc => "L'extension, sans le point (fr,com, ...)"            
    def generate(sComposeVersion,sTemplate,sEnv)        
        # arrete le processus si le chemin n'existe pas        
        sFullPath=find_in_source_paths(File.join(sComposeVersion,sTemplate,sEnv))
        
        say "Génération de #{sTemplate} en mode #{sEnv}", :blue
        say '------------------------------------------', :blue
        @clientname = options[:client] ? options[:client] : ask("Quel est le nom du client ? (en minuscule, sans espaces ou caractères spéciaux)")
        @machine = options[:machine] ? options[:machine] : ask("Quel est le nom de la machine ? (en minuscule, sans espaces ou caractères spéciaux)")
        @project  = options[:projet] ? options[:projet] : ask("Quel est le nom du projet ? (sans le www et l'extension)")
        sProjectWwwPrefix = options[:prefixe] ? options[:prefixe] : ask("Quel est le préfixe ? (www, auth, etc.)")
        sProjectWwwExtension = options[:extension] ? options[:extension] : ask("Quelle est l'extension ? (fr, com, etc.)")
        
        if sProjectWwwPrefix.empty?
            @fulldomain = @project
        else
            @fulldomain = sProjectWwwPrefix+"."+@project
        end
        
        if sProjectWwwExtension.empty?
            @domain = @project+"."+sProjectWwwExtension
        else
            @fulldomain = @fulldomain+"."+sProjectWwwExtension
            @domain = @project+"."+sProjectWwwExtension
        end

        # il faudrait ajouter quelques controles ou transformations (tout en minuscule, vérifier l'url, etc.)
        
        pwgen = PawGen.new.set_length!(12).include_uppercase!.include_digits!.exclude_ambiguous!
        
        # on génère et si c'est utilisé par le template, banco
        @root_pass_db= pwgen.generate
        @user_pass_db = pwgen.generate     
        @noreply_pass_smtp = pwgen.generate
        @backup_pass_smtp = pwgen.generate
        @user_pass_sftp = pwgen.generate
        @www_pass_ssh = pwgen.generate

        # on va écrire la sortie ici, géré par Thor :
        self.destination_root= OUTPUT_DIR        
        empty_directory(@fulldomain,{:verbose => false})
        
        # ça pourrait encore être simplifié avec l'utilisation de la fonction template, mais le passage des paramètres est différent.
        Dir.chdir(sFullPath)
        Dir.glob("*"+TEMPLATE_EXTNAME) { |sErbFileName|
            # le chemin complet du fichier destination
            sFileDest = File.join(self.destination_root,@fulldomain,File.basename(sErbFileName,TEMPLATE_EXTNAME))
            # on ouvre le fichier erb, et c'est parti, magie magie
            template_file = File.open(sErbFileName, 'r').read
            erb = ERB.new(template_file)
            File.open(sFileDest, 'w') { |file| file.write(erb.result(binding)) }
            # c'est tout !
        }

        say "Projet "
        say @fulldomain+" ",:green
        say "généré avec succès ( "
        say sComposeVersion+" ",:green
        say sTemplate+" ", :green
        say sEnv+' ', :green 
        say ')'        
        
        # on est toujours dans le bon dossier
        if File.file?("readme.rb")
            apply(File.join(sFullPath,"readme.rb"),{:verbose => false})
        end
    end
end

DockerComposeCreator.start(ARGV)