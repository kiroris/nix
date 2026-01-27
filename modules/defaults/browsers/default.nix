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
    browser = mkOption {
      type = enum [
        "firefox"
        "chromium"
      ];

      default = "firefox";
    };

    browserCmd = let
      browserExecs = {
        firefox = "${pkgs.firefox}/bin/firefox";
        chromium = "${pkgs.ungoogled-chromium}/bin/chromium";
      };
    in
      mkOption {
        type = str;
        default = browserExecs.${cfg.browser};
      };
  };
}
