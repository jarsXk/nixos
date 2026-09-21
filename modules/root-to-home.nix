{ config, lib, pkgs, ... }:

{
  system.activationScripts.moveRootHome = {
    text = ''
      if [ -d /root ] && [ ! -L /root ]; then
        echo "Moving /root to /home/root..."

        if [ -e /home/root ]; then
          echo "ERROR: /home/root already exists, refusing to overwrite it."
          exit 1
        fi

        mv /root /home/root
        ln -s /home/root /root

        echo "Done: /root -> /home/root"
      fi
    '';

    deps = [];
  };
}
