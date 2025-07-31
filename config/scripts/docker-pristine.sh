#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Docker pristine                                            ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"


echo "
┌──── Docker pristine containers
└───────────────────────────────────────────────────────────────────────────────
"
[[ -n "$(docker container ls --all --quiet)" ]] && docker container rm --force --volumes $(docker container ls --all --quiet)
docker container prune --force


echo "
┌──── Docker pristine images
└───────────────────────────────────────────────────────────────────────────────
"
[[ -n "$(docker image ls --all --quiet)" ]] && docker image rm --force $(docker image ls --all --quiet)
docker image prune --all --force


echo "
┌──── Docker pristine networks
└───────────────────────────────────────────────────────────────────────────────
"
docker network prune --force


echo "
┌──── Docker pristine volumes
└───────────────────────────────────────────────────────────────────────────────
"
[[ -n "$(docker volume ls --quiet)" ]] && docker volume rm --force $(docker volume ls --quiet)
docker volume prune --all --force


echo "
┌──── Docker pristine system
└───────────────────────────────────────────────────────────────────────────────
"
docker system prune --volumes --all --force

echo -e "\e[33mNow docker is clean!\e[0m"
