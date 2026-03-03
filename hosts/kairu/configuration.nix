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
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys =
  [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDG1VR3e2lJt0gZk8ZcAvfxlW1ogdiYqNGgyR7jcz7fZ sakanai@cum.army"
  ] ++ (args.extraPublicKeys or []); # this is used for unit-testing this module and can be removed if not needed
  users.users.root.hashedPassword = "$y$j9T$EMzGgYYZ1Vx7poi1SiHjx.$/M/mWC6ZlUcsqUmY4/cYC5AZ69WfVxVE3dFzl6AqIUB";

  system.stateVersion = "25.11";
}
