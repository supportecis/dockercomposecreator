say "--------------------------------------------------------------------------", :blue
say "Exemple fichier "+@fulldomain+".yml  à intégrer dossiers vhosts du proxy apache :", :blue
say "--------------------------------------------------------------------------", :blue
say "version: \"1.0\""
say "vhost:"
say "  name: "+@fulldomain
say "  alias:"
say "    - "+@domain
say "    - "+@fulldomain+"."+@machine+"."+@clientname+".as49517.net"
say "protocols:"
say "  http: yes"
say "  https: no"
say "backend:"
say "  protocol: http"
say "  host: "+@fulldomain+".vhost"
say "  port: 80"
say "  preserve_host: yes"
say "--------------------------------------------------------------------------", :blue
