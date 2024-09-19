
USER=andrefil
MARIA_DB_DIR=/home/$(USER)/data/mariadb
WP_PHP_DIR=/home/$(USER)/data/wordpress

DOCKER_COMPOSE=./srcs/docker-compose.yml
DOCKER_COMPOSE_EXEC=docker-compose -f $(DOCKER_COMPOSE)

all: config up

config:
	@echo "HELLO!!! WELCOME TO INCEPTION."

	@if [ ! -f ./srcs/.env ]; then \
		wget -O ./srcs/.env https://raw.githubusercontent.com/andrefil/Inception/main/srcs/.env; \
	fi

	@if ! grep -q '$(USER)' /etc/hosts; then \
		echo "127.0.0.1 $(USER).42.fr" | sudo tee -a /etc/hosts > /dev/null; \
	fi

	@if [ ! -d "$(WP_PHP_DIR)" ]; then \
		sudo mkdir -p $(WP_PHP_DIR); \
	fi
	@if [ ! -d "$(MARIA_DB_DIR)" ]; then \
		sudo mkdir -p $(MARIA_DB_DIR); \
	fi

up: build
	$(DOCKER_COMPOSE_EXEC) up -d

build:
	$(DOCKER_COMPOSE_EXEC) build

down:
	$(DOCKER_COMPOSE_EXEC) down

ps:
	$(DOCKER_COMPOSE_EXEC) ps

ls:
	docker volume ls

clean:
	$(DOCKER_COMPOSE_EXEC) down --rmi all --volumes

fclean: clean
	docker system prune --force --all --volumes
	sudo rm -rf /home/$(USER)

re: fclean all

.PHONY: all up config build down ls clean fclean hard update

hard: update all

update:
	sudo apt-get update && sudo apt-get upgrade -yq