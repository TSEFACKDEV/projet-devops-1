#!/bin/bash

# S'assurer que le script s'arrête en cas d'erreur
set -e

echo "=== 1. Mise à jour du système ==="
sudo apt-get update -y && sudo apt-get upgrade -y

echo "=== 2. Installation des prérequis (curl, git, etc.) ==="
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

echo "=== 3. Installation de Docker et Docker Compose ==="
# Ajouter la clé GPG officielle de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Configurer le dépôt Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installer Docker Engine
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "=== 4. Vérification de l'installation ==="
sudo docker --version
sudo docker compose version

echo "=== 5. Configuration du pare-feu (UFW) ==="
sudo apt-get install -y ufw

# Autoriser SSH pour ne pas perdre la main
sudo ufw allow 22/tcp

# Autoriser le port de notre application Node.js
sudo ufw allow 3000/tcp

# Activer le pare-feu de manière non interactive
sudo ufw --force enable

echo "=== Pare-feu configuré avec succès ! ==="

echo "=== Provisionnement terminé avec succès ! ==="

