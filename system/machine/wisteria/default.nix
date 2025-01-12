{ config
, ...
}:

{
  module = {
    #bluetooth.enable      = true;
    boot.enable           = true;
    # chaotic.
    #gaming.enable         = true;
    #lanzaboot.enable      = true;
    locales.enable        = true;
    minimal.enable        = true;
    network.enable        = true;
    nixos-ng.enable       = true;
    #pihole.enable         = true;
    plymouth.enable       = true;
    # programs.
    # security.
    # services.
    sound.enable          = true;
    timedate.enable       = true;
    users.enable          = true;
    variables.enable      = true;
    virtualisation.enable = true;
    #zapret.enable         = true;
    stylix.enable         = true;

    chaotic = {
      enable = true;
      schedulerType = "scx_bpfland";
    };

    security = {
      enable            = true;
      enableBootOptions = true;
      disableIPV6       = true;
    };

    services = {
      #adguard-home.enable = true;
      bolt.enable         = true;
      #cpu-autofreq.enable = true;
      #forgejo.enable      = true;
      fwupd.enable        = true;
      greetd.enable       = true;
      #homepage-dashboard.enable = true;
      #hyprland.enable     = true;
      #jellyfin.enable     = true;
      #mediamtx.enable     = true;
      #netbird.enable      = true;
      # ollama.
      polkit.enable       = true;
      #printing.enable     = true;
      qmk.enable          = true;
      sshd.enable         = true;
      syncthing.enable    = true;
      #tailscale.enable    = true;
      #tlp.enable          = true;
      udev.enable         = true;
      #unbound.enable      = true;
      #xserver.enable      = true;
      zram.enable         = true;

      ollama = {
        enable            = true;
        gpuSupport.enable = config.services.ollama.enable;
      };
    };

    programs = {
      dconf.enable          = true;
      fish.enable           = true;
      gnupg.enable          = true;
      hm.enable             = true;
      kdeconnect.enable     = true;
      mtr.enable            = true;
      nh.enable             = true;
      systemPackages.enable = true;
      xdg-portal.enable     = true;
      zsh.enable            = true;
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
#      adguard-home.enable = false;
#      bolt.enable         = false;
#      cpu-autofreq.enable = false;
#      forgejo.enable      = false;
#      fwupd.enable        = false;
#      greetd.enable       = false;
#      homepage-dashboard.enable = false;
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
