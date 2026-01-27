{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.plymouth;
in {
  options = {
    module.plymouth.enable = mkEnableOption "Enables plymouth";
  };

  config = mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      theme = lib.mkForce "rings";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = ["rings"];
        })
      ];
    };

    # Make plymouth work with sleep
    powerManagement = {
      powerDownCommands = ''
        ${pkgs.plymouth} --show-splash
      '';
      resumeCommands = ''
        ${pkgs.plymouth} --quit
      '';
    };
  };
}
