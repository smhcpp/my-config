{ config, pkgs, ... }:
let
in
{
  imports =
    [ # This line is CRITICAL. It points to your partition info.
      ./hardware-configuration.nix
      ./syspkgs.nix
    ];

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
  # Kanata Settings
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';
  services.kanata = {
    enable = true;
    keyboards.main-keyboard = {
      devices = [
        "/dev/input/by-path/pci-0000:01:00.0-usb-0:10:1.0-event-kbd"
      ];
      configFile = /home/mortimertz/.config/kanata/config.kbd;
    };
  };
  # --- Networking & Wi-Fi ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  
  # Your France 5GHz fixes for the driver
  boot.extraModprobeConfig = ''
    options 8821cu rtw_dfs_region_domain=3 rtw_country_code=FR rtw_switch_usb_mode=1 rtw_power_mgnt=0
  '';
  # Garbage Collection
  boot.loader.systemd-boot.configurationLimit = 3;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d"; # Deletes anything older than a week
  };
  nix.settings.auto-optimise-store = true;
  # --- Localization ---
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # --- Desktop (Niri) & Input ---
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  programs.fish.enable = true;

  # --- Dark Theme & Environment ---
  nixpkgs.config.allowUnfree = true;

  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";

  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    ADW_DISABLE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
  # --- User Account ---
  users.users.mortimertz = {
    isNormalUser = true;
    description = "Mortimertz";
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" "audio" "video"];
    shell = pkgs.fish;  
  };
  services.dbus.enable = true;


  security.rtkit.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "gtk";
    };
  # --- Packages ---
  environment.systemPackages = [];
  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "hx";
  system.stateVersion = "25.11"; 
}
