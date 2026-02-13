{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkDefault;

  cfg = config.module.minimal;
in {
  options = {
    module.minimal.enable = mkEnableOption "Debloated size";
  };

  config = mkIf cfg.enable {
    # Disable documentation
    documentation = {
      enable = mkDefault false;
      doc.enable = mkDefault false;
      info.enable = mkDefault false;
      man.enable = mkDefault false;
      man.man-db.enable = mkDefault false;
      man.mandoc.enable = mkDefault false;
      man.generateCaches = mkDefault false;
      nixos.enable = mkDefault false;
    };

    environment = {
      # Disable stub-ld, this exists to kill dynamically linked executables, since they cannot work
      # on NixOS, however we know that so we don't need to see the warning
      stub-ld.enable = false;

      # Disable all packages installed by default, I prefer my own packages
      # this list normally includes things like perl
      defaultPackages = lib.mkForce [];
    };

    services.logrotate.enable = mkDefault false;

    fonts.fontDir.decompressFonts = true;

    programs = {
      command-not-found.enable = mkDefault false;
      nano.enable = mkDefault false;
      less.lessopen = null;
    };
  };
}
