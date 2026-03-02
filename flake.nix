# top level flake
{
  inputs = {
    # nixpgks url
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nix wsl url
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
	
  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs: {
    nixosConfigurations.remus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
        # here is modules
	nixos-wsl.nixosModules.default
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nixos = import ./home.nix;
        }
      ];
    };
  };
}
