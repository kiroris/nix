{
  config,
  pkgs,
  ...
}: {
  # Kernel settings
  boot = {
    #kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelPackages = pkgs.linuxPackages_zen;

    extraModulePackages = [config.boot.kernelPackages.nvidia_x11];

    kernelModules = [
      #"kvm-intel"
      "kvm-amd"
      "amdgpu"
      "tcp_bbr"
      "tls"
    ];

    supportedFilesystems = [
      "nfs"
      "ntfs"
    ];

    initrd.kernelModules = [
      "nvidia"
    ];

    blacklistedKernelModules = [
      "nouveau"
    ];

    kernelParams = [
      "kernel.watchdog=0"
      # Video driver settings
      "nvidia_drm.fbdev=1"
    ];

    kernel.sysctl = {
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_bytes" = 268435456;
      "vm.dirty_expire_centisecs" = 1500;
      "vm.dirty_writeback_centisecs" = 100;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 1048576;
    };

    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "vmd"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];
  };
}
