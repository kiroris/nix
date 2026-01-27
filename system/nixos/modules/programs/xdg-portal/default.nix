{
  lib,
  config,
  pkgs,
  desktop,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.programs.xdg-portal;
in {
  options = {
    module.programs.xdg-portal.enable = mkEnableOption "Enable xdg-portal";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;

      config = {
        common = {
          default = "*";

          "org.freedesktop.impl.portal.Screencast" = desktop;
          "org.freedesktop.impl.portal.Screenshot" = desktop;
        };
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };
}
