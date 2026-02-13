_: {
  networking = {
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];

    firewall = {
      enable = true;

      allowedTCPPorts = [
        8384
        22000
        57621 # Spotify
        2257 # ssh
      ];

      allowedUDPPorts = [
        22000
        21027
        5353 # Spotify
      ];

      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];

      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };
  };
}
