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
    vim
    neovim
    tmux
    yazi
    alacritty
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
    slurp
    grim
    xdg-utils

    # --- Desktop Environment & Wayland (Niri/Waybar) ---
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
    gcc
    taplo
    clang
    gnumake
    pkg-config

    # --- Development: Language Servers & Formatters ---
    nixd
    pkgs.fish-lsp
    nixfmt-rfc-style
    lua-language-server
    wgsl-analyzer

    # --- Development: Libraries (GTK4/Adwaita) ---
    gtk4
    gtk4-layer-shell
    libadwaita
  ];
}
