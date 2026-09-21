{ machine, ... }:

{
  disko.devices = {
    disk.main = {
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
              mountOptions = [
                "umask=0077"
              ];
            };
          };

          root = {
            # Оставляем место под swap в конце диска
            size =
              if machine.swap.enable
              then null
              else "100%";

            end =
              if machine.swap.enable
              then "-${machine.swap.size}"
              else null;

            content = {
              type = "filesystem";
              format = "btrfs";

              mountpoint = "/";

              mountOptions = [
                "compress=zstd"
              ];

              subvolumes = {
                "@" = {
                  mountpoint = "/";
                };

                "@home" = {
                  mountpoint = "/home";
                };

                "@opt" = {
                  mountpoint = "/opt";
                };

                "@nix" = {
                  mountpoint = "/nix";
                };
              };
            };
          };

          swap = {
            # Всё оставшееся место = swap
            size = "100%";

            content = {
              type = "swap";
            };
          };
        };
      };
    };
  };
}