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

    stylix.enable = true;

    programs = {
      dconf.enable = true;
      gaming.enable = true;
      ##gnupg # not need
      hm.enable = true;
      kdeconnect.enable = true;
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
      bolt.enable = true;
      cpu-autofreq.enable = true;
      fwupd.enable = true;
      irqbalance.enable = true;
      journald.enable = true;
      ##netbird # LATER
      oomd.enable = true;
      polkit.enable = true;
      ##postgresql # LATER
      printing.enable = true;
      scx.enable = true;
      ssh.enable = true; # need check
      syncthing.enable = true;
      tailscale.enable = true;
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
