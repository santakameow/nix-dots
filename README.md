# nix-dots
meow!

## before
> i am a new user of nixOS

## structure
```
.
├── names.md -- some names that i choose for maybe new hosts
├── flake.nix -- top level flake
├── home.nix -- config for home-manager
└── hosts/
    ├── azari/
    │   └── configuration.nix -- nixos config for Azari (main pc)
    └── kairu/
        ├── configuration.nix -- nixos config for Kairu (server)
        ├── disk-config.nix
        └── facter.json 
```
