_:

{
  systemd.network = {
    enable = true;

    #networks.eth0 = {
    #  matchConfig.Name = "enp0s31f6";
    #  address = [ "192.168.1.50/24" ];
    #  dns = [ "192.168.1.8" ];
    #};
  };

  networking = {

    #nameservers = [
    #  "8.8.8.8"
    #  "8.8.4.4"
    #];

    firewall = {
      enable = false;

      allowedTCPPorts = [
        8384
        22000
        2257
        57621 # Spotify local discovery.
      ];

      allowedUDPPorts = [
        22000
        21027
        5353 # Spotify local discovery.
      ];

      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect.
      ];
      
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect.
      ];
    };
  };
}
