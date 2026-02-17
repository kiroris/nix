_: {
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  fileSystems = {
    "/boot" = {
      device = "UUID=0D8D-4BEA";
      fsType = "vfat";
      options = ["umask=0077"];
    };

    "/" = {
      device = "UUID=75acef4c-c3aa-4062-aa21-2d6826109e23";
      fsType = "ext4";
      options = [
        "defaults"
        "noatime"
      ];
    };
  };
}
