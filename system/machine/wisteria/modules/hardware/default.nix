{ lib
, machineModulesPath
, ...
}:

let
  hardwareModulesPath = "${machineModulesPath}/hardware";
in {
  # Import all machine hardware modules.
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${hardwareModulesPath}/${module}") (builtins.attrNames (builtins.readDir hardwareModulesPath))
  );
}
