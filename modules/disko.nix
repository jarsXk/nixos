{ machine, ... }:

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
        };

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
