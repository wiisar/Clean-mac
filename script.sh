#!/bin/bash

echo " Mot de passe admin requis..."
sudo -v

echo " Nettoyage du cache utilisateur..."
rm -rf ~/Library/Caches/*

echo " Nettoyage du cache système..."
sudo rm -rf /Library/Caches/*

echo " Suppression des logs utilisateur..."
rm -rf ~/Library/Logs/*

echo " Suppression des logs système..."
sudo rm -rf /Library/Logs/*

echo " Vidage de la corbeille..."
rm -rf ~/.Trash/*

echo " Nettoyage des mises à jour système obsolètes..."
sudo rm -rf /Library/Updates/*

# Optionnel : nettoyage du dossier Téléchargements
read -p "Souhaites-tu vider ton dossier Téléchargements ? (y/n) " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    rm -rf ~/Downloads/*
    echo " Dossier Téléchargements vidé."
else
    echo " Téléchargements conservés."
fi

echo " Relance des services de cache (mds et autres)..."
sudo killall mds > /dev/null 2>&1
sudo killall Finder
sudo killall Dock

echo " Nettoyage terminé ! Tu peux redémarrer pour finaliser."

