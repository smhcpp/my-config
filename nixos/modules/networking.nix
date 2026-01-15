{ ... }: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  # Using iwd for better WiFi performance
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
}
