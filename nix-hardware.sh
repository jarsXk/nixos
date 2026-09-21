#!/usr/bin/env bash

MACHINE="nixmatevm"
if [ "$#" -ge 1 ]; then
    MACHINE="$1"
fi

nixos-generate-config --root /mnt
if [ $? -ne 0 ]; then
    exit 1
fi

cp -f "/mnt/etc/nixos/hardware-configuration.nix" "./machines/$MACHINE/hardware.nix"
