# Symfony Docker Template

Ce projet est un template permettant d'initialiser rapidement un projet Symfony avec un environnement Docker préconfiguré. Il inclut PHP, Nginx et MySql

## 📌 Fonctionnalités

- **Dernier PHP stable** (tiré de l'image Docker officielle)
- **Nginx** en tant que serveur web
- **Configuration flexible** via `docker-compose.override.yml`
- **Gestion simplifiée** avec `Makefile`
- **Installation automatique de Symfony avec `webapp` et génération de `.env.local`**

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
   git clone https://github.com/votre-repo/docker-symfony-template.git template
   cd template
   ```

2. **Installation de Symfony et configuration initiale**

   ```sh
   make install name=new_project symfony=7.2.x
   ```
   
   - `name` : Nom du projet (par défaut `my_project`)
   - `symfony` : Version de Symfony à installer (par défaut `7.2`)

   Pendant l'installation :
   - Composer require webapp et installation des dependances
   - Un fichier `.env.local` sera automatiquement généré avec `DATABASE_URL` configurée.

3. **Construire et lancer les services du nouveau projet**

   ```sh
   cd ../new_project
   make up
   ```

4. **Accéder à l'application**

   - Symfony sera accessible sur : [http://localhost:8080](http://localhost:8080)

## 🛠️ Commandes utiles

### Lancer les services
```sh
make up
```

### Arrêter les services
```sh
make down
```

### Restart des services
```sh
make restart
```

### Accéder au container PHP
```sh
make shell
```

### Afficher les logs
```sh
make logs
```

### Composer
```sh
make composer 
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