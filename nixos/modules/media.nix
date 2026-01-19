{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-gstreamer
    ];
  };

  boot.extraModulePackages = with pkgs.linuxPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
}
