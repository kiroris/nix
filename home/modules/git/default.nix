{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.git;
in {
  options = {
    module.git.enable = mkEnableOption "Enables git";
  };

  config = mkIf cfg.enable {
    # Git config
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "kiroris";
          email = "kiroris@proton.me";
        };
      };

      #signing = {
      #  key = "7B6BA4FE97BE8BD3FA5E1E916B20D24B4760B605";
      #  signByDefault = true;
      #};

      includes = [
        {
          path = "~/Code/work/gitconfig";
          condition = "gitdir:~/Code/work/**";
        }
      ];
    };
  };
}
