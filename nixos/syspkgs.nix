# /etc/nixos/systempkgs.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Terminal & Shell Utilities ---
    libnotify
    mako
    bibata-cursors
    kanata
    git
    neovim
    tmux
    yazi
    alacritty
    gsettings-desktop-schemas
    glib
    foot
    unzip
    wl-clipboard
    wireplumber
    playerctl
    # --- Graphical Applications (Browsers) ---
    qutebrowser
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = "--ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode";
    })
    (brave.override {
      commandLineArgs = "--ozone-platform-hint=auto --force-dark-mode";
    })

    # --- Productivity & Creative ---
    gimp
    obs-studio
    github-desktop
    mpv
    kdePackages.okular
    loupe

    # --- Desktop Environment & Wayland (Niri/Waybar) ---
    slurp
    grim
    xdg-utils
    swaybg
    waybar
    fuzzel
    xwayland-satellite
    qt6.qtwayland
    xdg-desktop-portal-gnome

    # --- Development: Rust ---
    rustc
    cargo
    rust-analyzer
    clippy

    # --- Development: Zig & C/C++ ---
    zig
    zls
    fish-lsp
    gcc
    taplo
    clang
    gnumake
    pkg-config

    # --- Development: Language Servers & Formatters ---
    nixd
    nixfmt-rfc-style
    lua-language-server
    wgsl-analyzer

    # --- Development: Libraries (GTK4/Adwaita) ---
    gtk4
    gtk4-layer-shell
    libadwaita
  ];
}
