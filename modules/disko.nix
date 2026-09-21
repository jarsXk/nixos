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

              "@nix" = {
                mountpoint = "/nix";
              };

              "@opt" = {
                mountpoint = "/opt";
              };
            };
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
