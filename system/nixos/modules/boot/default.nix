{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.boot;
in {
  options = {
    module.boot.enable = mkEnableOption "Enables bootloader";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;

        # Prevent "too many" configurations from showing up on the boot menu
        #configurationLimit = 5;

        # The default is "keep"
        consoleMode = "max";

        # Fix a security hole. See description in
        # nixpkgs/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
        editor = false;
      };
    };
  };
}
