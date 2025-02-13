{ self
, pkgs
, lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.users;
in {
  options = {
    module.users.enable = mkEnableOption "Enables users.";
  };

  config = mkIf cfg.enable {
    users = {
      mutableUsers = false;

      groups = { 
        ${username} = {
          gid = 1000;
        };
      };

      users = {
        ${username} = {
          uid                = 1000;
          home               = "/home/${username}";
          shell              = pkgs.zsh;
          group              = "${username}";
          createHome         = true;
          description        = "${username}";
          isSystemUser       = true;
          hashedPasswordFile = "${self}/secrets/hashes/${username}.hash";

          extraGroups = [
            "video"
            "users"
            "adbusers"
            "wireshark"
            "audio"
            "networkmanager"
            "wheel"
            "docker"
            "libvirtd"
          ];
        };

        root = {
          shell = pkgs.fish;
          hashedPasswordFile = "${self}/secrets/hashes/root.hash";
        };
      };
    };
  };
}
