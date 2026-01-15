{ pkgs, ... }:
{
  users.users.mortimertz = {
    isNormalUser = true;
    description = "Mortimertz";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
      "audio"
      "video"
    ];
    shell = pkgs.fish;
  };

  # Global User Environment
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };
  programs.fish.enable = true;
}
