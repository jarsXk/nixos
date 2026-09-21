{ config, pkgs, machine, ... }:

{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = machine.hostname;

  time.timeZone = machine.timezone;

  users.users.${machine.username} = {
    isNormalUser = true;
    initialPassword = "p@ssword";

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

  swapDevices =
  if machine.swap.enable
  then [
    {
      device = "/dev/disk/by-partlabel/disk-main-swap-${machine.hostname}";
    }
  ]
  else [ ];

  system.stateVersion = "25.11";
}