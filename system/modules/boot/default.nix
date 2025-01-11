{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.boot;
in {
  options = {
    module.boot = {
      enable = mkEnableOption "Enables Bootloader";
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = lib.mkDefault 10;
      efi.canTouchEfiVariables = true;
      timeout = lib.mkForce 10;
    };
  };
}
