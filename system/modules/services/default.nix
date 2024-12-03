{ systemModules
, lib
, ...
}:

let
  hostServicesModulesPath = "${systemModules}/services";
in {
  # Import all services modules.
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${hostServicesModulesPath}/${module}") (builtins.attrNames (builtins.readDir hostServicesModulesPath))
  );
}
