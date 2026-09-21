{
  hostname = "nixmatevm";

  btrfs = {
    compression = "zstd:3";
  };

  username = "lesha";
  timezone = "Europe/Moscow";

  disk = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";

  swap = {
    enable = true;
    size = "1G";
  };

  desktop = "mate";

  encryption = {
    enable = true;
    tpm2 = true;
  };
}