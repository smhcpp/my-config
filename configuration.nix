{ config, pkgs, ... }:
let
  # We import the overlay and immediately call it with { } 
  # This turns it from a "function" into a "set" Nix can use.
  neovim-nightly-overlay = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
  });
in
{
  imports =
    [ # This line is CRITICAL. It points to your partition info.
      ./hardware-configuration.nix
    ];
  nixpkgs.overlays = [ neovim-nightly-overlay ];

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # --- Networking & Wi-Fi ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  
  # Your France 5GHz fixes for the driver
  boot.extraModprobeConfig = ''
    options 8821cu rtw_dfs_region_domain=3 rtw_country_code=FR rtw_switch_usb_mode=1 rtw_power_mgnt=0
  '';

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
  services.xserver.xkb = {
    layout = "us";
    options = "caps:super"; # The swap is here!
  };

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
    extraGroups = [ "networkmanager" "wheel" ];
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
  environment.systemPackages = with pkgs; [
    # Neovim 0.12 Nightly
    neovim 
    github-desktop
    wl-clipboard 
    obs-studio
    xdg-desktop-portal-gnome
    # --- Programming ---
    zig
    zls
    rustc
    cargo
    rust-analyzer
    clippy # Recommended since your config uses clippy for checkOnSave
    wgsl-analyzer
    lua-language-server
    gcc
    clang
    gnumake
    pkg-config
    gtk4
    gtk4-layer-shell
    libadwaita
    nil
    nixpkgs-fmt
    helix
    zellij
    # Browsers
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = "--ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode";
    })
    (brave.override {
      commandLineArgs = "--ozone-platform-hint=auto --force-dark-mode";
    })
    firefox

    # Niri & Wayland tools
    alacritty
    waybar
    fuzzel
    xwayland-satellite
    qt6.qtwayland
    wl-clipboard

    # Development & System
    git
    unzip
    vim
  ];

  system.stateVersion = "25.11"; 
}
