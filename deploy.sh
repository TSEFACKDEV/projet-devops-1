#!/bin/bash

echo "=== Déploiement de l'application Node.js ==="

# 1. Récupérer les derniers changements du code (ou simuler le build)
# git pull origin main

# 2. Stopper les anciens conteneurs proprement
docker compose down

# 3. Reconstruire et relancer les conteneurs en arrière-plan
docker compose up -d --build

echo "=== Application déployée et en ligne ! ==="