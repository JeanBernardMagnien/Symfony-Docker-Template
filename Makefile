USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)
name?=my_project
symfony?=7.2.x

install:
	@echo "🔹 Vérification de l'existence du projet..."
	@echo $(name)
	@if [ -d "../$(name)" ]; then echo "❌ Le projet $(name) existe déjà !"; exit 1; fi

	@echo "🚀 Création du projet Symfony dans $(name) - version Symfony: $(symfony)..."
	@docker run --rm -u $(USER_ID):$(GROUP_ID) -e SYMFONY_SKIP_DOCKER=1 -v $(PWD)/..:/app -w /app composer create-project symfony/skeleton:"$(symfony)" $(name)

	@echo "🔹 Installation des dépendances Symfony..."
	@sudo chown -R $(USER_ID):$(GROUP_ID) "../$(name)"
	@docker run --rm -u $(USER_ID):$(GROUP_ID) -v $(PWD)/../$(name):/app -w /app composer require webapp
	@docker run --rm -u $(USER_ID):$(GROUP_ID) -v $(PWD)/../$(name):/app -w /app composer install

	@echo "🔹 Suppression du fichier compose.yaml généré automatiquement par Symfony..."
	@rm -f "../$(name)/compose.yaml"
		
	@echo "🔹 Création du fichier .env.local pour la connexion à la BDD..."
	@echo "DATABASE_URL=mysql://root@database:3306/${name}" > "../$(name)/.env.local"

	@echo "🔹 Copie des fichiers Docker et Makefile..."
	@cp -r "$(PWD)/docker" "../$(name)/"
	@cp "$(PWD)/docker-compose.yml" "../$(name)/"
	@cp "$(PWD)/Makefile.project" "../$(name)/Makefile"

	@echo "🔹 Génération de la configuration Nginx..."
	@export PROJECT_NAME=$(name) && envsubst '$$PROJECT_NAME' < "$(PWD)/docker/nginx/default.conf.template" > "../$(name)/docker/nginx/default.conf"
	@rm -f "../$(name)/docker/nginx/default.conf.template"

	@echo "🔹 Attribution des permissions..."
	@sudo chown -R $(USER_ID):$(GROUP_ID) "../$(name)"
	@sudo chmod -R 755 "../$(name)"

	@echo "✅ Installation terminée !"
	@echo "➡️  Pour démarrer l'environnement Docker: cd ../$(name) && make up"   