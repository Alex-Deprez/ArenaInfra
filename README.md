# ArenaInfra

Configuration du NAS Synology qui héberge le serveur dédié d'[Arena](https://github.com/Alex-Deprez/ArenaServer).

L'image du serveur est construite par GitHub Actions et publiée sur `ghcr.io/alex-deprez/arena-server`. Le NAS ne fait que la récupérer : il n'a besoin ni de Godot ni du code du jeu.

## Installation

1. **Container Manager** : installe-le depuis le Centre de paquets.
2. **Dossier** : clone ce dépôt sur le NAS, par exemple dans `/volume1/docker/arena`.
3. **Projet** : dans Container Manager, va dans *Projet > Créer*, choisis ce dossier, qui contient le `docker-compose.yml`, puis lance-le.
   - Si le paquet GHCR est privé, connecte d'abord le NAS en SSH avec un token GitHub (droit `read:packages`) :
     `docker login ghcr.io -u Alex-Deprez`
4. **Pare-feu de DSM** : autorise le port **7777/UDP**.
5. **Box** : redirige le port **7777/UDP** vers l'IP locale du NAS (de préférence une IP fixe).
6. **DDNS** : dans *Panneau de configuration > Accès externe > DDNS*, crée une adresse `xxx.synology.me`.

Les joueurs se connectent ensuite à `xxx.synology.me:7777`.

### Vérifier le CGNAT

Compare l'IP WAN affichée par la box avec celle de https://whatismyip.com. Si elles diffèrent, la redirection de ports ne marchera pas : il faut demander une IPv4 publique à l'opérateur ou passer par un tunnel (Tailscale, par exemple).

## Mises à jour

`update.sh` récupère la dernière image et redémarre le serveur. Pour l'automatiser, va dans *Panneau de configuration > Planificateur de tâches > Créer > Tâche planifiée > Script défini par l'utilisateur* :

- utilisateur : `root` ;
- fréquence : toutes les 10 minutes, par exemple ;
- commande : `sh /volume1/docker/arena/update.sh`

## Logs

```sh
docker logs -f arena-server
```
