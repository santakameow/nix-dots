{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    btop
  ];
  programs.bash.enable = true;
  programs.home-manager.enable = true;
}
