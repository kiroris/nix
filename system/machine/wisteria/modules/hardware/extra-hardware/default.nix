{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkDefault;
in {
  # Extra drivers settings
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
    #cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;

    firmware = with pkgs; [
      linux-firmware
    ];

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
