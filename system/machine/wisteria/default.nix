{desktop ? null, ...}: {
  module = {
    binfmt.enable = true;
    bluetooth.enable = true;
    boot.enable = true;
    ##lanzaboote.enable = false;
    locales.enable = true;
    minimal.enable = true;
    network.enable = true;
    plymouth.enable = true;
    sound.enable = true;
    timedate.enable = true;
    users.enable = true;
    variables.enable = true;
    virtualization.enable = true;
    xdg.enable = true;
    zapret.enable = true;

    # stylix.enable = true;

    programs = {
      ##dconf
      gaming.enable = true;
      ##gnupg # not need
      hm.enable = true;
      kdeconnect.enable = true;
      ##mtr #????
      nh.enable = true;
      ##pihole
      systemPackages.enable = true;
      ##thunar
      xdg-portal.enable = true;
      zsh.enable = true;
    };

    security = {
      enable = true;
      enableBootOptions = true;
      disableIPV6 = true;
    };

    services = {
      ##adguard-home
      ##bolt
      cpu-autofreq.enable = true;
      ##fwupd # Later
      ##greetd
      ##gnome.enable = true;
      irqbalance.enable = true;
      journald.enable = true;
      ##netbird # later
      oomd.enable = true;
      polkit.enable = true;
      ##postgresql
      ##printing
      ##scx # расскидывает нагрузку по ядрам
      ssh.enable = true; # need check
      ##syncthing # синхранизация между хостами ИМБА!
      ##tailscale # FORRMATIIING!!!
      #tlp # Laptop
      udev.enable = true;
      zram.enable = true;
    };
  };

  nix.settings.trusted-users = [
    "kiroris"
    "root"
  ];
}
