{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.obs-studio;
in {
  options = {
    module.obs-studio.enable = mkEnableOption "Enables OBS";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        input-overlay
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
      ];
    };
  };
}
