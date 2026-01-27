{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.ssh;
in {
  options = {
    module.services.ssh.enable = mkEnableOption "Enables ssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [2257];

      settings = {
        PasswordAuthentication = true; # false
        KbdInteractiveAuthentication = false;
        AuthenticationMethods = "publickey";
        PubkeyAuthentication = "yes";
        ChallengeResponseAuthentication = "no";
        UsePAM = false;
        X11Forwarding = false;
        LogLevel = "VERBOSE";
        Ciphers = [
          "aes128-gcm@openssh.com"
          "aes256-gcm@openssh.com"
          "chacha20-poly1305@openssh.com"
          "aes256-ctr"
          "aes192-ctr"
          "aes128-ctr"
        ];
      };
    };
  };
}
