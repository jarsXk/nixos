{ config, pkgs, machine, ... }:

{
  networking.hostName = machine.hostname;

  time.timeZone = machine.timezone;

  users.users.${machine.username} = {
    isNormalUser = true;
    initialPassword = "p@ssword"

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    firefox
    git
    mc
    micro
    htop
  ];

  services.openssh.enable = true;

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}