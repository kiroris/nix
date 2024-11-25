{
  nixos = {
    wisteria = { #pcbox
      username      = "kiroris";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    nbox = {
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
