{
  modulesPath,
  lib,
  pkgs,
  ...
} @ args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hosts/kairu/disk-config.nix
  ];

  boot.loader.grub = {
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh.enable = true;

  # packages are here!
  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.fastfetch
    pkgs.btop
    pkgs.neovim
    pkgs.wget
    pkgs.dust
  ];

  users.users.root.openssh.authorizedKeys.keys =
  [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDG1VR3e2lJt0gZk8ZcAvfxlW1ogdiYqNGgyR7jcz7fZ sakanai@cum.army"
  ] ++ (args.extraPublicKeys or []); # this is used for unit-testing this module and can be removed if not needed

  # do not try decrypt this :<
  users.users.root.hashedPassword = "$y$j9T$EMzGgYYZ1Vx7poi1SiHjx.$/M/mWC6ZlUcsqUmY4/cYC5AZ69WfVxVE3dFzl6AqIUB";

  # network settings cuz hosting soo bad
  # probably all of lines need to be commented
  # after switching to new hosting
  networking = {
    hostName = "kairu";
    useDHCP = false;
    dhcpcd.enable = false;

    interfaces.ens18 = {
      ipv4 = {
        routes = [
          {
            address = "93.113.25.1";
            prefixLength = 24;
          }
        ];
        addresses = [
          {
            address = "93.113.25.151";
            prefixLength = 24;
          }
        ];
      };
    };

    defaultGateway = {
      address = "93.113.25.1";
      interface = "ens18";
    };

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  services.resolved.enable = true;

  system.stateVersion = "25.11";
}
