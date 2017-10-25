#!/bin/sh

echo "Qual o nome do projeto?"
read nomeProjeto

echo "Por favor, informe o nome pasta do projeto:"
read nomePasta

pasta="/home/brliand/apache_server/$nomePasta"

echo "Agora, informe o endereço (URL) pelo qual deseja acessar o projeto"
read url

cd /etc/httpd/conf/vhosts

arquivoConf="$nomeProjeto.conf"

sudo touch $arquivoConf
sudo chmod 777 $arquivoConf

conteudo="<VirtualHost $url:80>\n
    DocumentRoot \"$pasta\" \n
    ServerName $url \n
    ErrorLog \"/var/log/httpd/aml/$nomeProjeto.log\" \n
</VirtualHost>"

sudo echo -e $conteudo >> $arquivoConf

forHosts="\n127.0.0.1\t$url"

folderHosts="/etc/hosts"

sudo chmod 777 $folderHosts
sudo echo -e $forHosts >> $folderHosts
sudo chmod 644 $folderHosts

sudo systemctl restart httpd