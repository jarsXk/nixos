#!/usr/bin/env bash

nix --extra-experimental-features 'nix-command flakes' flake check
if [ $? -ne 0 ]; then
    exit 1
fi
nixos-rebuild dry-build --flake .#"${1:nixmatevm}"