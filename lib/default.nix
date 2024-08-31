{ self
, inputs
, ...
}:

let
  homeConfiguration   = "${self}/home";
  systemConfiguration = "${self}/system";

  homeModules         = "${homeConfiguration}/modules";
  systemModules       = "${systemConfiguration}/modules";
  commonModules       = "${self}/modules";
in {

  mkHost = 
    { hostname ? "nixos"
    , username ? "kiroris"
    , stateVersion ? "24.05"
    , platform ? "x86_64-linux" 
    , isWorkstation ? false
    , wm ? null
    }:
    let
      machineConfigurationPath      = "${self}/system/machine/${hostname}";
      machineConfigurationPathExist = builtins.pathExists machineConfigurationPath;
      machineModulesPath            = "${self}/system/machine/${hostname}/modules";
      machineModulesPathExist       = builtins.pathExists machineModulesPath;

      swayEnable     = wm == "sway";
      hyprlandEnable = wm == "hyprland";
      gnomeEnable    = wm == "gnome";
      wmEnable       = hyprlandEnable || swayEnable || gnomeEnable;
    in inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit 
          inputs
          self
          hostname
          username
          stateVersion
          platform
          isWorkstation
          wm
          homeModules
          commonModules
          systemModules
          machineConfigurationPath
          machineConfigurationPathExist
          machineModulesPath
          machineModulesPathExist
          hyprlandEnable
          swayEnable
          gnomeEnable
          wmEnable;
      };

      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.impermanence.nixosModules.impermanence
        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote

        "${systemConfiguration}"
        "${homeConfiguration}"
      ];
    };

  # Helper function for generating darwin host configs
  mkHostDarwin = 
    { hostname ? "mac"
    , username ? "kiroris"
    , stateVersion ? 6
    , platform ? "aarch64-darwin" 
    }:
    inputs.darwin.lib.darwinSystem {
      specialArgs = {
        inherit 
          inputs
          self
          hostname
          username
          platform
          stateVersion
          systemModules
          commonModules;
      };

      modules = [
        "${systemConfiguration}"
        "${homeConfiguration}"
      ];
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}