{
  description = "Kiroris Flake.";

  inputs = {
    # Official NixOS repo.
    master = {
      url = "github:NixOS/nixpkgs/master";
    };

    # Lates stable version.
    stable = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    # Unstable version.
    unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # Current nixpkgs branch.
    nixpkgs = {
      follows = "unstable";
    };

    # NixOS community.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix user repositories.
    nur = {
      url = "github:nix-community/NUR";
    };

    # Declarative partitioning and formatting of a disk.
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative management of the ephemeral root file system.
    impermanence = {
      url = "github:/nix-community/impermanence";
    };

    # Simplify Nix Flake with the module system.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # System-wide colorscheming and typography for NixOS.
    stylix = {
      url = "github:danth/stylix";
    };

    # Formatting files of various programming languages in a project.???
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };

    # Nix Flake from Chaotic(providing access to unstable versions of programs and experimental modules).
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };

    # Generate infrastructure and network diagrams as Svg.
    nix-topology = {
      url = "github:oddlama/nix-topology";
    };

    # MacOS configuration.
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland ecosystem.
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=c5feee1e357f3c3c59ebe406630601c627807963";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    # Xdg-Desktop-Portal backend for Hyprland.
    xdghypr = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland/v1.3.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Unoficial users flakes.???
    any-nix-shell = {
      url = "github:TheMaxMur/any-nix-shell";
    };

    # Tiny monorepo for sci-comp things that don't fit in nixpkgs.
    cryptopro = {
      url = "github:SomeoneSerge/pkgs";
    };

    # Tool for the secure management of secrets in the NixOS system(provides their encryption, decryption).
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    # Secure Boot.
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
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
    # Description of hosts.
    #hosts = import ./hosts.nix; 

    # Import helper funcfions.
    #libx = import ./lib { inherit self inputs; };
  in flake-parts.lib.mkFlake { inherit inputs; } {
    systems = libx.forAllSystems;

    imports = [
      #./parts
      #./docs
    ];

    flake = {
      # NixOS Hosts configuration.
      nixosConfigurations = libx.genNixos hosts.nixos;

      # MacOS Hosts configuration.
      darwinConfigurations = libx.genDarwin hosts.darwin;

      # Templates.
      #templates = import "${self}/templates" { inherit self; };
    };
  };
}
