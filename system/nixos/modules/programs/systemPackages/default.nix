{
  lib,
  config,
  pkgs,
  isWorkstation,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib) optionals;

  cfg = config.module.programs.systemPackages;
in {
  options = {
    module.programs.systemPackages.enable = mkEnableOption "Enable System Software";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu-mono
      corefonts
    ];

    environment.systemPackages = with pkgs;
      [
        # Utils
        tldr
        git
        nvd
        nix-output-monitor
        curl
        wget
        tree
        file
        zip
        unrar-free
        p7zip
        unzip
        killall
        jq
        waypipe

        # Hardware utils
        mesa-demos
        pciutils
        usbutils
        powertop
        lm_sensors
        strace
        ltrace
        lsof
        sysstat
        cpufetch
        sbctl

        # Network
        inetutils
        wireguard-tools
        dig
        nmap
        dnsutils
        iperf3
        mtr
        ipcalc
        cacert
        nfs-utils
        sshfs
      ]
      ++ optionals isWorkstation [
        # Hardware
        #microcode-intel
        microcode-amd
        libGL

        # Hardware utils
        libva-utils
        intel-gpu-tools
        fwupd
        fwupd-efi

        # Utils
        dconf-editor
      ];
  };
}
