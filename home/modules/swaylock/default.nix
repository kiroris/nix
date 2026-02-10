{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkDefault;

  cfg = config.module.swaylock;
in {
  options = {
    module.swaylock = {
      enable = mkEnableOption "Enable swaylock";
    };
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;

      settings = {
        ignore-empty-password = true;
        #indicator-idle-visible = true;
        indicator-radius = 150;

        #no-unlock-indicator = true;
        hide-keyboard-layout = true;

        color = mkDefault "282828";
        daemonize = true;
        line-uses-ring = true;
        show-failed-attempts = true;
      };
    };
  };
}
