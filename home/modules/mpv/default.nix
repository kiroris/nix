{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.mpv;
in {
  options = {
    module.mpv.enable = mkEnableOption "Enables mpv";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;

      scripts = [
        pkgs.mpvScripts.mpris
      ];

      config = {
        profile = "gpu-hq";
        vo = "gpu-next";
        force-window = true;
        hwdec = "auto";
        ao = "pipewire,alsa,coreaudio";
        video-sync = "display-resample";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
