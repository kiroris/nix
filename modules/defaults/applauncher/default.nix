{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum str;

  cfg = config.module.defaults;
in {
  options.module.defaults = {
    appLauncher = mkOption {
      type = enum [
        "wofi"
        "rofi-wayland"
        "fuzzel"
      ];

      default = "wofi";
    };

    appLauncherCmd = let
      appLauncherExecs = {
        rofi-wayland = "${pkgs.rofi-wayland}/bin/rofi -show drun";
        wofi = "${pkgs.wofi}/bin/wofi --show drun";
        fuzzel = "${pkgs.fuzzel}/bin/fuzzel --show drun";
      };
    in
      mkOption {
        type = str;
        default = appLauncherExecs.${cfg.appLauncher};
      };
  };
}
