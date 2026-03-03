{ pkgs, ... }:

{
  # nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # home
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    btop
    lazygit
    go
  ];
  # programs 
  programs.bash.enable = true;
  programs.home-manager.enable = true;
  programs.ssh = {
    enable = true;
    matchBlocks = {
      kairu = {
        hostname = "93.113.25.151";
	user = "root";
      };
    };
  };
}
