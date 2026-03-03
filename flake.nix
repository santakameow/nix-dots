{
  description = "flake for sakanai devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # urls for server
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  };
	
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    disko,
    nixos-facter-modules,
    ... 
  }@inputs: {
    nixosConfigurations.azari = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
	nixos-wsl.nixosModules.default
        ./hosts/azari/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nixos = import ./home.nix;
        }
      ];
    };
    nixosConfigurations.kairu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
	./hosts/kairu/configuration.nix
        nixos-facter-modules.nixosModules.facter
	{ hardware.facter.reportPath = ./hosts/kairu/facter.json }
	{
          config.facter.reportPath = 
	    if builtins.pathExists ./hosts/kairu/facter.json then
	      ./hosts/kairu/facter.json
	    else
	      throw "probably you run `nixos-anywere` with `--generate-hardware-config nixos-facter ./hosts/kairu/facter.json`?";
	}
      ];
    };
  };
}
