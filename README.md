# Symfony Docker Template

Ce projet est un template permettant d'initialiser rapidement un projet Symfony avec un environnement Docker préconfiguré. Il inclut PHP, Nginx et MySql

## 📌 Fonctionnalités

- **Dernier PHP stable** (tiré de l'image Docker officielle)
- **Nginx** en tant que serveur web
- **Configuration flexible** via `docker-compose.override.yml`
- **Gestion simplifiée** avec `Makefile`
- **Installation automatique de Symfony avec `webapp` et génération de `.env.local`**
- **Ports dynamiques** générés automatiquement par projet pour éviter les conflits

## 📂 Structure du projet
```
docker-symfony-template/
│── docker/
│   ├── php/             # Configuration PHP
│   │   ├── php.ini
│   │   ├── Dockerfile
│   │   ├── bashrc
│   ├── nginx/           # Configuration Nginx
│   │   ├── default.conf.template
│── docker-compose.override.yml   # Variables supplémentaires pour l'environnement
│── docker-compose.yml   
│── Makefile             
```

## 🚀 Installation et Lancement

### 1️⃣ Prérequis

- Docker et Docker Compose installés
- GNU Make installé (`sudo apt install make` si nécessaire)

### 2️⃣ Initialisation du projet

1. **Cloner ce template dans le dossier du futur projet**
```sh
   git clone https://github.com/JeanBernardMagnien/Symfony-Docker-Template template
   cd template
```

2. **Installation de Symfony et configuration initiale**
```sh
   make install name=new_project symfony=7.2.x
```
   
   - `name` : Nom du projet (par défaut `my_project`)
   - `symfony` : Version de Symfony à installer (par défaut `7.2`)

   Pendant l'installation :
   - Composer require webapp et installation des dépendances
   - Un fichier `.env.local` sera automatiquement généré avec `DATABASE_URL`, `NGINX_PORT` et `DB_PORT` configurés
   - Les ports sont **calculés automatiquement** à partir du nom du projet et restent fixes pour ce projet
   - Les ports attribués sont affichés à la fin de l'installation

3. **Construire et lancer les services du nouveau projet**
```sh
   cd ../new_project
   make up
```

4. **Accéder à l'application**

   Les ports sont affichés à chaque `make up` et `make start`. Pour les retrouver à tout moment :
```sh
   make info
```
   - 🗄️ MySQL → `localhost:{DB_PORT}` (plage 3300-3399)
   - 🌐 App   → `http://localhost:{NGINX_PORT}` (plage 8000-8999)

## 🛠️ Commandes utiles

### Construire et démarrer les services (première fois ou après un `down`)
```sh
make up
```

### Stopper les containers sans les détruire
```sh
make stop
```

### Redémarrer les containers stoppés
```sh
make start
```

### Redémarrer les containers (stop + start, sans reconstruction)
```sh
make restart
```

### Détruire les containers (les volumes et données sont conservés)
```sh
make down
```

### Supprimer complètement l'environnement Docker (⚠️ supprime aussi les données)
```sh
make clean
```

### Afficher les URLs et ports du projet
```sh
make info
```

### Accéder au container PHP
```sh
make shell
```

### Afficher les logs
```sh
make logs
```

### Console Symfony
```sh
make console
```

### Création migrations
```sh
make db-migrations
```

### Mettre à jour la base de données
```sh
make db-migrate
```

### Charger les fixtures
```sh
make db-fixtures
```

### Vider le cache Symfony
```sh
make cache-clear
```

## 🏗️ Configuration avancée

### Ports
Les ports sont générés automatiquement à l'installation et stockés dans `.env.local`. Il est possible de les modifier manuellement dans ce fichier si nécessaire :
```env
NGINX_PORT=8042
DB_PORT=3342
```

### PHP
Les paramètres PHP sont configurables dans `docker/php/php.ini` :
```ini
memory_limit = 512M
upload_max_filesize = 128M
post_max_size = 128M
max_execution_time = 300
display_errors = On
```

### Nginx
Le fichier `docker/nginx/default.conf.template` contient la configuration du serveur web.