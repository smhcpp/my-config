# /etc/nixos/systempkgs.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Terminal & Shell Utilities ---
    fzf
    libnotify
    kanata
    git
    neovim
    zellij
    tree
    tmux
    yazi
    alacritty
    gsettings-desktop-schemas
    glib
    foot
    lazygit
    p7zip
    unzip
    wl-clipboard
    wireplumber
    playerctl
    # --- Graphical Applications (Browsers) ---
    zapzap
    bibata-cursors
    telegram-desktop
    discord
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
    ghostty
    gimp
    github-desktop
    mpv
    kdePackages.okular
    loupe
    # --- Desktop Environment & Wayland (Niri/Waybar) ---
    mako
    slurp
    grim
    xdg-utils
    swaybg
    waybar
    fuzzel
    xwayland-satellite
    qt6.qtwayland
    xdg-desktop-portal-gnome

    # --- Development: Zig , Rust , Nix ---
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
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
