{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.foot;

  serverEnable =
    if config.module.defaults.terminal == "foot-client"
    then true
    else false;
in {
  options = {
    module.foot.enable = mkEnableOption "Enables Foot";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = serverEnable;

      settings = {
        main = {
          app-id = "foot";
          title = "foot";
          locked-title = "no";
          term = "foot";
          resize-delay-ms = 100;
          workers = 16;
          #initial-window-size-chars = "115x24";
          pad = "5x2"; # "12x21 center"
        };

        cursor = {
          style = "block"; # beam - I
          #beam-thickness = 2;
        };

        mouse = {
          hide-when-typing = "no";
        };

        #key-bindings = {
        #  clipboard-copy = "Control+c XF86Copy";
        #  clipboard-paste = "Control+v XF86Paste";
        #  noop = "Mod4+space";
        #};

        #text-bindings = {
        #  "\\x03" = "Control+Shift+c Control+Shift+C";
        #};
      };
    };
  };
}
