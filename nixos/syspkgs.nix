{pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    # Neovim 0.12 Nightly
    neovim 
    github-desktop
    wl-clipboard 
    obs-studio
    xdg-desktop-portal-gnome
    zig
    zls
    rustc
    cargo
    rust-analyzer
    clippy 
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
    tmux
    zellij
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = "--ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode";
    })
    (brave.override {
      commandLineArgs = "--ozone-platform-hint=auto --force-dark-mode";
    })
    firefox
    alacritty
    waybar
    fuzzel
    xwayland-satellite
    qt6.qtwayland
    wl-clipboard
    gimp
    git  
    unzip
    vim
  ];
}
