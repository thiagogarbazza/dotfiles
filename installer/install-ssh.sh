#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration ssh                              ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

echo "Configure XDG Base Directory specification"
mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/ssh
ln --symbolic --force ${XDG_CONFIG_HOME:-$HOME/.config}/ssh $HOME/.ssh

echo "Generate ssh keys"
ssh-keygen -q -t rsa -b 4096 -C "1093328+thiagogarbazza@users.noreply.github.com" -f "$HOME/.config/ssh/id_rsa_github" -N ''
