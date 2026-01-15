{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./syspkgs.nix
    ./modules/boot.nix
    ./modules/gaming.nix
    ./modules/desktop.nix
    ./modules/networking.nix
    ./modules/input.nix
    ./modules/locale.nix
    ./users/mortimertz.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import (builtins.fetchTarball "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz")) ];

  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  system.stateVersion = "25.11";
}
