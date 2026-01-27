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
      ##gnupg
      hm.enable = true;
      kdeconnect.enable = true;
      ##mtr
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
      #cpu-autofreq # Laptop
      ##fwupd # Later
      ##greetd
      ##gnome.enable = true;
      irqbalance.enable = true;
      journald.enable = true;
      ##netbird
      oomd.enable = true;
      polkit.enable = true;
      ##postgresql
      ##printing
      ##scx
      ##searxng
      ssh.enable = true;
      ##syncthing
      ##tailscale # FORRMATIIING!!!
      #tlp # Laptop
      ##udev # Later
      ##unbound # Later
      zram.enable = true;
    };
  };

  nix.settings.trusted-users = [
    "kiroris"
    "root"
  ];
}
