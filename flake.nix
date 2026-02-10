{
  description = "Kiroris flake";

  inputs = {
    # Official NixOS repository
    master = {
      url = "github:NixOS/nixpkgs/master";
    };

    # Unstable branch
    unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # Latest stable
    stable = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };

    # Current nixpkgs branch
    nixpkgs = {
      follows = "unstable";
    };

    # NixOS community
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs: let
    # Description of hosts
    hosts = import ./hosts.nix;
    # Import helper funcfions
    libx = import ./lib {inherit self inputs;};
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = libx.forAllSystems;

      imports = [
        ./parts
      ];

      flake = {
        # NixOS Hosts configuration
        nixosConfigurations = libx.genNixos hosts.nixos;
      };
    };
}
