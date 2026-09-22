#!/usr/bin/env bash

FLAKE=".#nixsandbox"
if [ "$#" -ge 1 ]; then
    FLAKE=".#$1"
fi

nix --extra-experimental-features 'nix-command flakes' flake check
if [ $? -ne 0 ]; then
    exit 1
fi

nixos-rebuild dry-build --flake $FLAKE
