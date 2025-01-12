{ config
, ...
}:

{
  module = {
    bluetooth.enable      = false;
    boot.enable           = false;
    gaming.enable         = false;
    lanzaboot.enable      = false;
    locales.enable        = false;
    minimal.enable        = false;
    network.enable        = false;
    nixos-ng.enable       = false;
    pihole.enable         = false;
    plymouth.enable       = false;
    sound.enable          = false;
    timedate.enable       = false;
    users.enable          = false;
    variables.enable      = false;
    virtualisation.enable = false;
    zapret.enable         = false;
    stylix.enable         = false;

    chaotic = {
      enable = false;
      schedulerType = "scx_bpfland";
    };

    security = {
      enable            = false;
      enableBootOptions = false;
      disableIPV6       = false;
    };

    services = {
      adguard-home        = false;
      bolt.enable         = false;
      cpu-autofreq.enable = false;
      forgejo.enable      = false;
      fwupd.enable        = false;
      greetd.enable       = false;
      homepage-dashboard  = false;
      hyprland.enable     = false;
      jellyfin.enable     = false;
      mediamtx.enable     = false;
      netbird.enable      = false;
      polkit.enable       = false;
      printing.enable     = false;
      qmk.enable          = false;
      sshd.enable         = false;
      syncthing.enable    = false;
      tailscale.enable    = false;
      tlp.enable          = false;
      udev.enable         = false;
      unbound.enable      = false;
      xserver.enable      = false;
      zram.enable         = false;

      ollama = {
        enable            = false;
        gpuSupport.enable = config.services.ollama.enable;
      };
    };

    programs = {
      dconf.enable          = false;
      fish.enable           = false;
      gnupg.enable          = false;
      hm.enable             = false;
      kdeconnect.enable     = false;
      mtr.enable            = false;
      nh.enable             = false;
      systemPackages.enable = false;
      xdg-portal.enable     = false;
      zsh.enable            = false;
    };
  };
}
#{
#  module = {
#    bluetooth.enable      = false;
#    boot.enable           = false;
#    gaming.enable         = false;
#    lanzaboot.enable      = false;
#    locales.enable        = false;
#    minimal.enable        = false;
#    network.enable        = false;
#    nixos-ng.enable       = false;
#    pihole.enable         = false;
#    plymouth.enable       = false;
#    sound.enable          = false;
#    timedate.enable       = false;
#    users.enable          = false;
#    variables.enable      = false;
#    virtualisation.enable = false;
#    zapret.enable         = false;
#    stylix.enable         = false;
#
#    chaotic = {
#      enable = false;
#      schedulerType = "scx_bpfland";
#    };
#
#    security = {
#      enable            = false;
#      enableBootOptions = false;
#      disableIPV6       = false;
#    };
#
#    services = {
#      adguard-home        = false;
#      bolt.enable         = false;
#      cpu-autofreq.enable = false;
#      forgejo.enable      = false;
#      fwupd.enable        = false;
#      greetd.enable       = false;
#      homepage-dashboard  = false;
#      hyprland.enable     = false;
#      jellyfin.enable     = false;
#      mediamtx.enable     = false;
#      netbird.enable      = false;
#      polkit.enable       = false;
#      printing.enable     = false;
#      qmk.enable          = false;
#      sshd.enable         = false;
#      syncthing.enable    = false;
#      tailscale.enable    = false;
#      tlp.enable          = false;
#      udev.enable         = false;
#      unbound.enable      = false;
#      xserver.enable      = false;
#      zram.enable         = false;
#
#      ollama = {
#        enable            = false;
#        gpuSupport.enable = config.services.ollama.enable;
#      };
#    };
#
#    programs = {
#      dconf.enable          = false;
#      fish.enable           = false;
#      gnupg.enable          = false;
#      hm.enable             = false;
#      kdeconnect.enable     = false;
#      mtr.enable            = false;
#      nh.enable             = false;
#      systemPackages.enable = false;
#      xdg-portal.enable     = false;
#      zsh.enable            = false;
#    };
#  };
#}
