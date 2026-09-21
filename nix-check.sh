#!/usr/bin/env bash

nix --extra-experimental-features 'nix-command flakes' flake check
if [ $? -ne 0 ]; then
    exit 1
fi
FLAKE=".#${1:nixmatevm}"
echo $FLAKE
nixos-rebuild dry-build --flake $FLAKE
