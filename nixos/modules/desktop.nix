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
    noto-fonts-color-emoji
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono # "IntelliJ" default font
    nerd-fonts.fira-code # "Firacode"
    nerd-fonts.mononoki # "Monokai" style font
    nerd-fonts.iosevka # "Ioskova"
    nerd-fonts.iosevka-term # Terminal optimized version
    nerd-fonts.hack
    nerd-fonts.ubuntu
    nerd-fonts.meslo-lg # Popular Apple-style font
    nerd-fonts.comic-shanns-mono # Fun alternative
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
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
        };
      };
    }
  ];
  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    MOZ_ENABLE_WAYLAND = "1";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    XDG_CURRENT_DESKTOP = "niri";
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common = {
      default = "gtk";
    };
  };
}
