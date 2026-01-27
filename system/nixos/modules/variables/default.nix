{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.variables;
in {
  options = {
    module.variables.enable = mkEnableOption "Enables variables";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland:xcb";
      DISABLE_QT5_COMPAT = "0";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
    };

    environment.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
