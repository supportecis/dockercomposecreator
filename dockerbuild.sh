#!/bin/bash
echo "*************************"
echo Mise à jour de ruby:alpine
echo "*************************"
docker pull ruby:alpine
echo "*************************"
echo Génération du Gemfile.lock
echo "*************************"
docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:alpine bundle install
echo "*************************"
echo Build du dockerfile
echo "*************************"
docker build -t registry.teikhos.eu/misc/dcc:latest .
echo "*************************"
echo Envoi sur la registry
echo "*************************"
docker push registry.teikhos.eu/misc/dcc:latest
