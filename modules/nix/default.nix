{ inputs
, lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.nix-config;
in {
  options = {
    module.nix-config = {
      enable = mkEnableOption "Enables nix-config.";

      useNixPackageManagerConfig = mkOption {
        type = types.bool;
        description = "Whether to use custom Nix package manager settings.";
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    # Nixpkgs config.
    nixpkgs.config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        "electron-27.3.11"
        "electron-25.9.0"
        "electron-19.1.9"
        #"fluffychat-linux-1.20.0"
        #"olm-3.2.16"
      ];
    };

    # Nix package manager settings.
    nix = {
      package = pkgs.nixVersions.latest;
      registry.s.flake = inputs.self;

      settings = {
        #nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;

        substituters = [
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://hyprland.cachix.org"
          "https://nyx.chaotic.cx"
        ];

        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        ];
      };

      # Optimise settings.
      optimise = {
        dates = ["weekly"];
        automatic = true;
      };

      # Garbage collector settings.
      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
      };
    };
  };
}
