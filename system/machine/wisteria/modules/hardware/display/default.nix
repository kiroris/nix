{username, ...}: let
  settings = {
    sway = {
      output = {
        DP-1 = {
          resolution = "1680x1050@60Hz";
          position = "0 0";
        };

        HDMI-A-1 = {
          resolution = "2560x1440@143.981Hz";
          position = "1680 0";
        };
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "HDMI-A-1";
        }
        {
          workspace = "2";
          output = "HDMI-A-1";
        }
        {
          workspace = "3";
          output = "HDMI-A-1";
        }
        {
          workspace = "4";
          output = "HDMI-A-1";
        }
        {
          workspace = "5";
          output = "HDMI-A-1";
        }
        {
          workspace = "6";
          output = "HDMI-A-1";
        }
        {
          workspace = "7";
          output = "DP-1";
        }
        {
          workspace = "8";
          output = "DP-1";
        }
        {
          workspace = "9";
          output = "DP-1";
        }
        {
          workspace = "10";
          output = "DP-1";
        }
        {
          workspace = "11";
          output = "DP-1";
        }
        {
          workspace = "12";
          output = "DP-1";
        }
      ];
    };

    hyprland = {
      monitor = [
        "DP-1,1680x1050@60,0x0,1"
        "HDMI-A-1,2560x1440@143.981,1680x0,1"
      ];

      workspace = [
        "1,  monitor:HDMI-A-1, default:true"
        "2,  monitor:HDMI-A-1, default:true"
        "3,  monitor:HDMI-A-1, default:true"
        "4,  monitor:HDMI-A-1, default:true"
        "5,  monitor:HDMI-A-1, default:true"
        "6,  monitor:HDMI-A-1, default:true"
        "7,  monitor:DP-1,    default:true"
        "8,  monitor:DP-1,    default:true"
        "9,  monitor:DP-1,    default:true"
        "10, monitor:DP-1,    default:true"
        "11, monitor:DP-1,    default:true"
        "12, monitor:DP-1,    default:true"
      ];
    };
  };
in {
  home-manager.users.${username}.wayland.windowManager = {
    sway.config = settings.sway;
    hyprland.settings = settings.hyprland;
  };
}
