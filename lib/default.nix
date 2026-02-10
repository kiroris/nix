{
  self,
  inputs,
  ...
}: let
  defaultStateVersion = "25.05";

  constructors = [
    "${self}/home"
    "${self}/system"
  ];

  allDirs = dirName:
    builtins.filter (
      module: ((builtins.pathExists module) && ((builtins.readFileType module) == "directory"))
    ) (map (module: "${dirName}/${module}") (builtins.attrNames (builtins.readDir dirName)));

  # Helper function for generating host configs
  mkHost = machineDir: {
    username ? "user",
    stateVersion ? defaultStateVersion,
    hmStateVersion ? stateVersion,
    platform ? "x86_64-linux",
    hostname ? machineDir,
    isWorkstation ? false,
    desktop ? null,
    theme ? "nord",
    hostType ? "nixos",
  }: let
    swayEnable = desktop == "sway";
    hyprlandEnable = desktop == "hyprland";
    wmEnable = hyprlandEnable || swayEnable;
    gnomeEnable = desktop == "gnome";
    nixosSystem =
      if stateVersion == defaultStateVersion
      then inputs.stable.lib.nixosSystem
      else inputs.nixpkgs.lib.nixosSystem;
  in
    nixosSystem {
      # system = platform; # crutch for dev
      specialArgs = {
        inherit
          inputs
          self
          allDirs
          hostname
          username
          stateVersion
          hmStateVersion
          platform
          machineDir
          isWorkstation
          desktop
          theme
          hyprlandEnable
          swayEnable
          wmEnable
          gnomeEnable
          hostType
          ;
      };

      modules = with inputs;
        [
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          #impermanence.nixosModules.impermanence
          #disko.nixosModules.disko
          #lanzaboote.nixosModules.lanzaboote
          #chaotic.nixosModules.default
          #sops-nix.nixosModules.sops
          #nur.modules.nixos.default
        ]
        ++ constructors;
    };
in {
  forAllSystems = inputs.nixpkgs.lib.systems.flakeExposed;

  genNixos = builtins.mapAttrs mkHost;
}
