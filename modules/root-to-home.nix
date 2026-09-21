{ ... }:

{
  systemd.services.move-root-to-home = {
    description = "Move /root to /home/root";

    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    requires = [ "local-fs.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      set -euo pipefail

      if [ -L /root ] && [ "$(readlink /root)" = "../home/root" ]; then
        exit 0
      fi

      mkdir -p /home/root

      find /root -mindepth 1 -maxdepth 1 \
        -exec mv -t /home/root -- {} +

      rmdir /root
      ln -s ../home/root /root
    '';
  };
}