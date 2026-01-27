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
    terminal = mkOption {
      type = enum [
        "foot"
        "foot-client"
      ];

      default = "foot-client";
    };

    terminalCmd = let
      terminalExecs = {
        foot = "${pkgs.foot}/bin/foot";
        foot-client = "${pkgs.foot}/bin/footclient";
      };
    in
      mkOption {
        type = str;
        default = terminalExecs.${cfg.terminal};
      };
  };
}
