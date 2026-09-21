#!/usr/bin/env bash

FLAKE=".#nixmatevm"
if [ "$#" -ge 1 ]; then
    FLAKE=".#$1"    
fi

nixos-install --flake $FLAKE