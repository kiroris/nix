{
  nixos = {
    wisteria = { # pcbox.
      username      = "kiroris";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    pion = { # pcbox.
      username      = "xtentmin";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "hyprland";
    };

    lycoris = { # nbox.
      username      = "kiroris";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    rasp = {
      username      = "kiroris";
      platform      = "aarch64-linux";
      stateVersion  = "24.11";
      isWorkstation = false;
    };
  };

  darwin = {
    macbox = {
      username      = "kiroris";
      platform      = "aarch64-darwin";
      stateVersion  = 6;
      isWorkstation = true;
    };
  };
}
