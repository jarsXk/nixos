#!/usr/bin/env bash

FLAKE=".#nixmatevm"
if [ "$#" -ge 1 ]; then
    FLAKE=".#$1"    
fi

MODE="format,mount"
if [ "$#" -ge 2 ] && [ "$2" == "destroy" ]; then
    MODE="destroy,format,mount"
fi

nix --extra-experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode $MODE --flake $FLAKE