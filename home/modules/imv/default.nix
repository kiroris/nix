{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.imv;
in {
  options = {
    module.imv.enable = mkEnableOption "Enables imv";
  };

  config = mkIf cfg.enable {
    programs.imv = {
      enable = true;
    };
  };
}
