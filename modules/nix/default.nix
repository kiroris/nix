{
  lib,
  config,
  pkgs,
  username,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) bool;

  cfg = config.module.nix-config;
in {
  options = {
    module.nix-config = {
      enable = mkEnableOption "Enables nix-config";

      useNixPackageManagerConfig = mkOption {
        type = bool;
        description = "Whether to use custom Nix package manager settings";
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    # Nixpkgs config
    nixpkgs.config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;

      permittedInsecurePackages = [
        "olm-3.2.16"
        "intel-media-sdk-23.2.2"
      ];
    };

    # Nix package manager settings
    nix = {
      package = pkgs.lix;
      registry.s.flake = inputs.self;

      # set the nix store to clean every Monday at 7pm
      # gc.dates = "Mon *-*-* 19:00";

      # automatically optimize /nix/store by removing hard links
      # optimise = {
      #   automatic = true;
      #   dates = [ "19:00" ];
      # };

      # Make builds run with a low priority, keeping the system fast
      # daemonCPUSchedPolicy = "idle";
      # daemonIOSchedClass = "idle";
      # daemonIOSchedPriority = 7;

      settings = {
        allowed-users = ["@wheel"];

        trusted-users = [
          "root"
          username
        ];

        # this defaults to true, however it slows down evaluation so maybe we should disable it
        # some day, but we do need it for catppuccin/nix so maybe not too soon
        allow-import-from-derivation = true;

        # don't warn me if the current working tree is dirty
        # i don't need the warning because i'm working on it right now
        warn-dirty = false;

        # continue building derivations even if one fails
        # this is important for keeping a nice cache of derivations, usually because I walk away
        # from my PC when building and it would be annoying to deal with nothing saved
        keep-going = true;

        # show more log lines for failed builds, as this happens alot and is useful
        log-lines = 30;

        # let the system decide the number of max jobs
        max-jobs = "auto";

        # cgroups yea
        use-cgroups = true;

        # automatically optimise symlinks
        auto-optimise-store = true;

        # use xdg base directories for all the nix things
        use-xdg-base-directories = true;

        # build inside sandboxed environments
        sandbox = true;

        # Supported system features
        system-features = [
          "nixos-test"
          "kvm"
          "recursive-nix"
          "big-parallel"
        ];

        extra-experimental-features = [
          "nix-command"
          "flakes"
          "cgroups"
          "auto-allocate-uids"
        ];

        substituters = [
          "https://nix-community.cachix.org"
          "https://hyprland.cachix.org"
          "https://nyx.chaotic.cx"
          "https://nixpkgs-python.cachix.org"
          "https://devenv.cachix.org"
        ];

        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        ];
      };

      gc = mkIf (!config.module.programs.nh.enable or false) {
        automatic = true;
        options = "--delete-older-than 7d";
      };
    };
  };
}
