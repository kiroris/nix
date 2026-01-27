#{
#  pkgs,
#  ...
#}:
_: {
  services.xserver.videoDrivers = [
    "amdgpu" # "nvidia"
  ];

  #nixpkgs.config.cudaSupport = true;

  #hardware.nvidia = {
  #  open = true;
  #  modesetting.enable = true;
  #  powerManagement.enable = true;
  #  dynamicBoost.enable = true;
  #  nvidiaSettings = false;
  #};

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    #extraPackages = with pkgs; [
    #  nvidia-vaapi-driver
    #];
  };
}
