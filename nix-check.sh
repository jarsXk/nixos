#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
    FLAKE=".#nixmatevm"
else
    FLAKE=".#$1"
fi

echo $#
echo $1
echo $FLAKE

nix --extra-experimental-features 'nix-command flakes' flake check
if [ $? -ne 0 ]; then
    exit 1
fi

nixos-rebuild dry-build --flake $FLAKE
