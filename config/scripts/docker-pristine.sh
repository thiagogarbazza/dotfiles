#!/bin/bash
set -euo pipefail

echo -e "\e[33mDocker pristine build\e[0m"
docker buildx prune --all --force
docker builder prune --all --force


echo -e "\e[33mDocker pristine containers\e[0m"
[[ -n "$(docker container ls --all --quiet)" ]] && docker container rm --force --volumes $(docker container ls --all --quiet)
docker container prune --force


echo -e "\e[33mDocker pristine images\e[0m"
[[ -n "$(docker image ls --all --quiet)" ]] && docker image rm --force $(docker image ls --all --quiet)
docker image prune --all --force


echo -e "\e[33mDocker pristine networks\e[0m"
docker network prune --force


echo -e "\e[33mDocker pristine volumes\e[0m"
[[ -n "$(docker volume ls --quiet)" ]] && docker volume rm --force $(docker volume ls --quiet)
docker volume prune --all --force


echo -e "\e[33mDocker pristine system\e[0m"
docker system prune --all --force --volumes

echo -e "\e[32mNow docker is clean! \e[0m"
docker system df
