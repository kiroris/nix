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

  # Helper function for generating host configs.
  mkHost = machineDir:
    { username ? "user"
    , stateVersion ? "24.05"
    , platform ? "x86_64-linux" 
    , hostname ? machineDir
    , isWorkstation ? false
    , wm ? null
    }:
    let
      machineConfigurationPath      = "${self}/system/machine/${machineDir}";
      machineConfigurationPathExist = builtins.pathExists machineConfigurationPath;
      machineModulesPath            = "${self}/system/machine/${machineDir}/modules";
      machineModulesPathExist       = builtins.pathExists machineModulesPath;

      swayEnable     = wm == "sway";
      hyprlandEnable = wm == "hyprland";
      wmEnable       = hyprlandEnable || swayEnable;
    in inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit 
          inputs
          self
          hostname
          username
          stateVersion
          platform
          machineDir
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
          wmEnable;
      };

      modules = [
        "${systemConfiguration}"
        "${homeConfiguration}"
      ];
    };

  # Helper function for generating darwin host configs.
  mkHostDarwin = hostname:
    { username ? "user"
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
in {
  forAllSystems = inputs.nixpkgs.lib.systems.flakeExposed;

  # This function just add mkHost or mkHostDarwin before hosts attrset.
  # ex: pcbox = { username = "test"; stateVersion = "24.11"; }; ->
  # pcbox = mkHost { username = "test"; stateVersion = "24.11"; };
  genNixos  = builtins.mapAttrs mkHost;
  genDarwin = builtins.mapAttrs mkHostDarwin;
}
