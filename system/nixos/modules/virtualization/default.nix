{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.virtualization;
in {
  options = {
    module.virtualization.enable = mkEnableOption "Enables virtualisation";
  };

  config = mkIf cfg.enable {
    # Virtualization settings
    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    virtualisation = {
      docker = {
        enable = true;
        extraPackages = with pkgs; [docker-compose];
        #storageDriver = "btrfs";
      };

      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          #ovmf.enable = true;
        };
      };
    };
  };
}
