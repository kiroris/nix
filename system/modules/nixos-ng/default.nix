{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.nixos-ng;
in {
  options = {
    module.nixos-ng = {
      enable = mkEnableOption "Enables nixos-ng.";
    };
  };

  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = true;
    # systemd.sysusers.enable = true; ### break.

    services = {
      #userborn.enable     = true;
      dbus.implementation = "broker";
    };

    system = {
      switch = {
        enable = false;
        enableNg = true;
      };

      /* etc.overlay = {
        enable = true;
        mutable = true;
      }; */
    };
  };
}
