# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rliu <rliu@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/22 09:32:59 by rliu              #+#    #+#              #
#    Updated: 2022/12/22 09:33:13 by rliu             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


NAME			:=	inception
VERSION			:=	1.0

SRCS_DIR		:=	srcs

COMPOSE_FILE	:=	${SRCS_DIR}/docker-compose.yml
ENV_FILE		:=	${SRCS_DIR}/.env

FLAGS			:=	-f ${COMPOSE_FILE} \
					-p ${NAME}


all: build

build:
	@mkdir -p /home/rliu/data/database
	@mkdir -p /home/rliu/data/www
	@docker compose ${FLAGS} up -d --build
	@echo "ready - docker services are up"

start:
	@docker compose ${FLAGS} start 2> /dev/null
	@echo "ready - docker services have been started"

stop:
	@docker compose ${FLAGS} stop 2> /dev/null
	@echo "stopped - docker services have been stopped"

status:
	@docker compose ${FLAGS} ps

clean:
	@docker compose  ${FLAGS} down --rmi  all -v || true 
	@echo "info - stop and delete container and networks\n cleaned docker images(s)"
	@echo "info - cleaned docker volumes(s)"

fclean: clean
	@sudo rm -rf /home/rliu/data >/dev/null
	@echo "info - cleaned local data"

re:  fclean all

.PHONY: all start stop status fclean clean re
