{ pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;

  # WiFi/Driver Fixes
  boot.kernelModules = [ "uinput" ];
  boot.extraModprobeConfig = ''
    options 8821cu rtw_dfs_region_domain=3 rtw_country_code=FR rtw_switch_usb_mode=1 rtw_power_mgnt=0
  '';
}
