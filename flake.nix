{
  description = "Kiroris Flake."

  inputs = {
    # Official NixOS repo.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    # NixOS community.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative disk management.
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Remove junk files and directories.
    impermanence.url = "github:/nix-community/impermanence";

    # Customize the theme.
    stylix.url = "github:danth/stylix";

    # MacOS configuration.
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland.
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #xdghypr = {
    #  url = "github:hyprwm/xdg-desktop-portal-hyprland/v1.3.1";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};


    # Unoficial users flakes.
    any-nix-shell.url = "github:TheMaxMur/any-nix-shell";
    cryptopro.url = "github:SomeoneSerge/pkgs";

    # Security.
    sops-nix.url = "github:Mic92/sops-nix";

    # Securely boot.
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Just for pretty flake.nix.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Zsh plugins.
    powerlevel10k = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };

    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };

    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };

    fzf-zsh-completions = {
      url = "github:chitoku-k/fzf-zsh-completions";
      flake = false;
    };

    zsh-history-substring-search = {
      url = "github:zsh-users/zsh-history-substring-search";
      flake = false;
    };

    zsh-auto-notify = {
      url = "github:MichaelAquilina/zsh-auto-notify";
      flake = false;
    };
  };

  outputs = { self, flake-parts, ... } @ inputs:
  let
    # Import helper funcfions.
    #libx = import ./lib { inherit self inputs; };

    # Description of hosts.
    hosts = {
      # Main PC.
      wisteria = {
        hostname      = "wisteria";
        username      = "kiroris";
        platform      = "x86_64-linux";
        stateVersion  = "24.11";
        isWorkstation = true;
        wm            = "hyprland";
      };

      # Main Laptop.
      lycoris = {
        hostname      = "lycoris";
        username      = "kiroris";
        platform      = "x86_64-linux";
        stateVersion  = "24.11";
        isWorkstation = true;
        wm            = "gnome";
      };
    };

  in flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    flake = {
      nixosConfigurations = {
        ${hosts.wisteria.hostname} = libx.mkHost hosts.wisteria;
        ${hosts.lycoris.hostname}  = libx.mkHost hosts.lycoris;
      };

    #  darwinConfigurations = {
    #  #  #${hosts.macbox.hostname} = libx.mkHostDarwin hosts.macbox;
    #  };

      #templates = import "${self}/templates" { inherit self; };
    };
  };
}
