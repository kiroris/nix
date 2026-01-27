{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.binfmt;
in {
  options = {
    module.binfmt.enable = mkEnableOption "Enable binfmt";
  };

  config = mkIf cfg.enable {
    boot.binfmt = {
      # Our archs that we want to emulate
      registrations = {
        windows = {
          interpreter = "${pkgs.wine}/bin/wine";
          offset = 0;
          magicOrExtension = ".exe"; # or "MZ"
        };
      };
    };
  };
}
