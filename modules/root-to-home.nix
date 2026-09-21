{ ... }:

{
  system.activationScripts.moveRootToHome = {
    text = ''
      set -euo pipefail

      # Уже настроено
      if [ -L /root ] && [ "$(readlink /root)" = "../home/root" ]; then
        exit 0
      fi

      # Убедиться, что /home/root существует
      mkdir -p /home/root
      chown root:root /home/root
      chmod 700 /home/root

      # Если /root — обычный каталог, переносим всё его содержимое
      if [ -d /root ] && [ ! -L /root ]; then
        find /root -mindepth 1 -maxdepth 1 \
          -exec mv -t /home/root -- {} +

        rmdir /root
      fi

      # Создаём относительную ссылку
      ln -s ../home/root /root
    '';
  };
}