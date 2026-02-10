{
  isWorkstation,
  hyprlandEnable ? false,
  swayEnable ? false,
  wmEnable ? false,
  ...
}: {
  #stylix.targets = {
  #  helix.enable = false;
  #  nvf.enable = false;
  #};

  module = {
    btop.enable = true;
    chromium.enable = isWorkstation;
    eza.enable = true;
    #fastfetch
    firefox.enable = isWorkstation; # change config
    foot.enable = wmEnable && isWorkstation;
    fzf.enable = true; # fix zshIntegration
    git.enable = true; # add key
    #hypridle
    #hyprland
    #hyprlock
    #hyprpaper
    imv.enable = isWorkstation;
    lazygit.enable = true;
    mpd.enable = true;
    mpv.enable = isWorkstation;
    nvim.enable = true; # change config
    #obs-studio.enable = isWorkstation; # just not now
    #password-store
    ripgrep.enable = true;
    #rofi
    ssh.enable = isWorkstation;
    sway.enable = swayEnable && isWorkstation;
    #swaylock.enable = swayEnable && isWorkstation; # later
    #swaync
    tealdeer.enable = true;
    #thunderbird
    tmux.enable = true; # change config
    #waybar
    #wofi
    yazi.enable = true; # fix a zsh integration & change config
    zathura.enable = isWorkstation;
    #zed
    zoxide.enable = true;
    #zsh.enable = true; # FIX IT FUCK

    #user = {
    #  xdg.enable = isWorkstation;
    #  variables.enable = isWorkstation;
    #  #impermanence.enable = isWorkstation;
    #  shellAliases.enable = true;
    #  packages.enable = true;
    #};
  };
}
