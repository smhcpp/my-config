{ pkgs, ... }:
{
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  programs.dconf.enable = true;
  services.flatpak.enable = true;
  security.rtkit.enable = true;
  services.dbus.enable = true;
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  systemd.user.extraConfig = ''
    DefaultEnvironment="WAYLAND_DISPLAY=wayland-1"
  '';
  systemd.user.services.xdg-desktop-portal-gtk = {
    wantedBy = [ "xdg-desktop-portal.service" ];
    before = [ "xdg-desktop-portal.service" ];
  };
  # Theming
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    MOZ_ENABLE_WAYLAND = "1";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common = {
      default = "gtk";
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
    };
  };
}
