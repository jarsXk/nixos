{
  hostname = "nixmatevm";

  btrfs = {
    compression = "zstd:3";
  };

  username = "lesha";
  timezone = "Europe/Moscow";

  disk = "/dev/nvme0n1";

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