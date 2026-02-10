{
  lib,
  config,
  pkgs,
  self,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.sway;

  browser = config.module.defaults.browserCmd;
  terminal = config.module.defaults.terminalCmd;
in {
  imports = [
    "${self}/home/modules/sway/keybinds"
  ];

  options = {
    module.sway.enable = mkEnableOption "Enable sway";
  };

  config = mkIf cfg.enable {
    module.sway = {
      keybindings.enable = cfg.enable;
    };

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
      GTK_CSD = "0";
      GTK_USE_PORTAL = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    gtk = {
      gtk3.extraConfig = {
        gtk-decoration-layout = ":";
      };

      gtk4.extraConfig = {
        gtk-decoration-layout = ":";
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      systemd.xdgAutostart = true;
      checkConfig = false;

      extraConfig = ''
        for_window [shell="xwayland"] title_format "[XWayland] %title"
      '';

      config = {
        focus.mouseWarping = "container";
        workspaceAutoBackAndForth = false; # true

        input = {
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0.6";
          };

          "type:keyboard" = {
            xkb_layout = "us,ru";
            xkb_options = "grp:caps_toggle";
            #xkb_variant = "colemak";
            repeat_delay = "300";
            repeat_rate = "60";
          };

          "type:touchpad" = {
            natural_scroll = "enabled";
            tap = "enabled";
            #drag = "enabled";
            #scroll_factor = "0.5";
            click_method = "button_areas";
          };
        };

        gaps = {
          inner = 7;
        };

        bars = [];

        window = {
          titlebar = false;
          border = 4;
        };

        #startup = [
        #  { command = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"; }
        #  { command = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"; }
        #  { command = "${pkgs.sway}/bin/swaymsg 'workspace 1; exec ${browser}'"; }
        #  { command = "${pkgs.sway}/bin/swaymsg 'workspace 5; exec ${terminal}'"; }
        #];
      };
    };
  };
}
