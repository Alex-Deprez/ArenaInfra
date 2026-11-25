#!/bin/sh
# Récupère la dernière image du serveur et redémarre le conteneur si elle a changé.
# À planifier dans DSM : Panneau de configuration > Planificateur de tâches (utilisateur root).
set -e
cd "$(dirname "$0")"

if docker compose version >/dev/null 2>&1; then
	DC="docker compose"
else
	DC="docker-compose"
fi

$DC pull -q
$DC up -d
docker image prune -f >/dev/null
