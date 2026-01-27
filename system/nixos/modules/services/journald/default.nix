{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.module.services.journald;
in {
  options = {
    module.services.journald.enable = mkEnableOption "Journald tuning";
  };

  config = mkIf cfg.enable {
    # limit systemd journal size
    # https://wiki.archlinux.org/title/Systemd/Journal#Persistent_journals
    services.journald.extraConfig = ''
      SystemMaxUse=100M
      RuntimeMaxUse=50M
      SystemMaxFileSize=50M
    '';
  };
}
