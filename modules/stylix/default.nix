{
  pkgs,
  lib,
  self,
  config,
  hostname,
  theme,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib) optionalAttrs;
  inherit (lib.types) bool;

  cfg = config.module.stylix;

  cursorSize =
    if hostname == "lycoris"
    then 24
    else 14;

  themes = {
    nord = {
      scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      wallpaper = "${self}/assets/wallpapers/grey_gradient.png";

      font = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font Mono";
      };

      cursor = {
        name = "Vimix-cursors";
        package = pkgs.vimix-cursors;
      };
    };

    biscuit = {
      scheme = "${self}/assets/colorschemes/biscuit.yaml";
      wallpaper = "${self}/assets/wallpapers/grey_gradient.png";

      font = {
        package = pkgs.kirsch;
        name = "kirsch";
      };

      cursor = {
        name = "WhiteSur Cursors";
        package = pkgs.whitesur-cursors;
      };
    };

    gruvbox = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
      wallpaper = "${self}/assets/wallpapers/windowsxp.jpeg";

      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };

      cursor = {
        package = pkgs.material-cursors;
        name = "material_light_cursors";
      };

      #icons = {
      #  dark = "oomox-gruvbox-dark";
      #  package = pkgs.gruvbox-dark-icons-gtk;
      #};
    };
  };
in {
  options = {
    module.stylix = {
      enable = mkEnableOption "Enables stylix";

      useCursor = mkOption {
        type = bool;
        default = true;
        description = "Enable cursor settings";
      };
    };
  };

  config = mkIf cfg.enable {
    stylix =
      {
        enable = true;
        #enableReleaseChecks = false; # Enable for debug
        #image = themes.${theme}.wallpaper;
        autoEnable = true;
        polarity = "dark";
        #base16Scheme = themes.${theme}.scheme;
        #icons = themes.${theme}.icons;

        opacity = {
          applications = 1.0;
          terminal = 0.9;
          popups = 1.0;
          desktop = 1.0;
        };

        fonts = {
          sizes = {
            applications = 11;
            terminal = 11;
            popups = 12;
            desktop = 11;
          };

          serif = {
            inherit (themes.${theme}.font) package name;
          };

          sansSerif = config.stylix.fonts.serif;
          monospace = config.stylix.fonts.serif;
          emoji = config.stylix.fonts.serif;
        };
      }
      // optionalAttrs cfg.useCursor {
        cursor = {
          inherit (themes.${theme}.cursor) package name;
          size = cursorSize;
        };
      };
  };
}
