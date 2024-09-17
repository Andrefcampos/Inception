LOGIN=andrefil
MARIA_DIR=/home/$(LOGIN)/data/mariadb
WORDPRESS_DIR=/home/$(LOGIN)/data/wordpress

DOCKER_COMPOSE_FILE=./srcs/docker-compose.yaml
DOCKER_COMPOSE_COMMAND=docker-compose -f $(DOCKER_COMPOSE_FILE)

all: config up

config:
	@echo oi

# 	@if [ ! -f ./srcs/.env ]; then \
# 		wget -O ./srcs/.env https://raw.githubusercontent.com/andrefcampos/inception/main/srcs/.env; \
# 	fi

	@if ! grep -q '$(LOGIN)' /etc/hosts; then \
		echo "127.0.0.1 $(LOGIN).42.fr" | sudo tee -a /etc/hosts > /dev/null; \
	fi

	@if [ ! -d "$(WORDPRESS_DIR)" ]; then \
		sudo mkdir -p $(WORDPRESS_DIR); \
	fi
	@if [ ! -d "$(MARIA_DIR)" ]; then \
		sudo mkdir -p $(MARIA_DIR); \
	fi

up: build
	$(DOCKER_COMPOSE_COMMAND) up -d

build:
	$(DOCKER_COMPOSE_COMMAND) build

down:
	$(DOCKER_COMPOSE_COMMAND) down

ps:
	$(DOCKER_COMPOSE_COMMAND) ps

ls:
	docker volume ls

clean:
	$(DOCKER_COMPOSE_COMMAND) down --rmi all --volumes

fclean: clean
	docker system prune --force --all --volumes
	sudo rm -rf /home/$(LOGIN)

re: fclean all

.PHONY: all up config build down ls clean fclean hard update

hard: update all

update:
	sudo apt-get update && sudo apt-get upgrade -yq