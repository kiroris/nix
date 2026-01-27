{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.programs.gaming;
in {
  options = {
    module.programs.gaming.enable = mkEnableOption "Enables things needed for gaming";
  };

  config = mkIf cfg.enable {
    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;

        settings = {
          general = {
            softrealtime = true;
          };

          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 1;
          };
        };
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };

      steam = {
        enable = true;
        package = pkgs.steam.override {
          extraPkgs = pkgs: [
            pkgs.gperftools
            pkgs.pkgsi686Linux.gperftools
          ];
          extraEnv = {
            # support cyrillic symbols
            LANG = "ru_RU.UTF-8";
          };
          extraBwrapArgs = [
            "--bind $HOME/Games/steamhome $HOME"
            "--bind $HOME/Games/Steam $HOME/.local/share/Steam"
          ];
        };
        extraCompatPackages = [pkgs.proton-ge-bin];
      };
    };

    environment.systemPackages = with pkgs; [
      mangohud
      wineWow64Packages.wayland
      lutris
      dualsensectl

      # Remote gaming
      moonlight-qt
      #parsec-bin

      # Minecraft
      openal
      glfw3-minecraft
    ];

    services.udev.extraRules = ''
      # PS5 DualSense controller over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"

      # PS5 DualSense controller over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"
    '';
  };
}
