{ lib, machine, ... }:

{
  disko.devices.disk.main = {
    type = "disk";
    device = machine.disk;

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        root = {
          content = {
            type = "btrfs";

            mountOptions = [
              "compress=${machine.btrfs.compression}"
            ];

            subvolumes = {
              "@" = {
                mountpoint = "/";
              };

              "@home" = {
                mountpoint = "/home";
              };

              "@games" = {
                mountpoint = "/games";
              };

              "@nix" = {
                mountpoint = "/nix";
              };

              "@opt" = {
                mountpoint = "/opt";
              };
            };

            postMountHook = ''
              mkdir -p /mnt/home/root
              ln -sfn ../home/root /mnt/root
            '';
          };
        }
        // (
          if machine.swap.enable
          then {
            end = "-${machine.swap.size}";
          }
          else {
            size = "100%";
          }
        );
      } // lib.optionalAttrs machine.swap.enable {
        swap = {
          size = "100%";

          content = {
            type = "swap";
          };
        };
      };
    };
  };
}
