#!/bin/bash

# Demande de mot de passe admin
echo "Mot de passe admin requis..."
sudo -v

initial_space=$(df -H / | tail -1 | awk '{print $4}')

echo "Nettoyage du cache utilisateur..."
rm -rf ~/Library/Caches/*

echo "Nettoyage du cache système..."
sudo rm -rf /Library/Caches/*

echo "Suppression des logs..."
rm -rf ~/Library/Logs/*
sudo rm -rf /Library/Logs/*

echo "Vidage de la corbeille..."
rm -rf ~/.Trash/*

echo "Nettoyage des mises à jour système obsolètes..."
sudo rm -rf /Library/Updates/*

echo "Nettoyage des fichiers de développement (Xcode, simulators)..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*
rm -rf ~/Library/Developer/Xcode/Archives/*
rm -rf ~/Library/Developer/CoreSimulator/Caches/*
rm -rf ~/Library/Developer/CoreSimulator/Devices/*/data/Library/Caches/*

echo "Nettoyage Docker (images, conteneurs, volumes non utilisés)..."
if command -v docker &> /dev/null; then
  docker system prune -a -f --volumes
else
  echo "Docker n'est pas installé."
fi

echo "Nettoyage du cache Homebrew..."
if command -v brew &> /dev/null; then
  brew cleanup -s
  rm -rf ~/Library/Caches/Homebrew/*
else
  echo "Homebrew n'est pas installé."
fi

echo "Suppression des fichiers .DS_Store..."
find ~ -name ".DS_Store" -delete

# Dossier Téléchargements
read -p "Souhaites-tu vider ton dossier Téléchargements ? (y/n) " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    rm -rf ~/Downloads/*
    echo "Dossier Téléchargements vidé."
else
    echo "Téléchargements conservés."
fi

echo "Recherche de gros fichiers (>500 Mo)..."
find ~ -type f -size +500M -exec ls -lh {} \; 2>/dev/null | awk '{ print $9 ": " $5 }'

echo "Relance de services système..."
sudo killall mds > /dev/null 2>&1
sudo killall Finder
sudo killall Dock

final_space=$(df -H / | tail -1 | awk '{print $4}')
echo "Nettoyage terminé."

echo "Espace libre AVANT : $initial_space"
echo "Espace libre APRÈS : $final_space"

