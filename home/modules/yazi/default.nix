{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.yazi;
in {
  options = {
    module.yazi.enable = mkEnableOption "Enables yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        log.enabled = false;

        mgr = {
          sort_dir_first = true;
          sort_sensitive = true;
          linemode = "size";
          show_symlink = true;
        };
      };
    };
  };
}
