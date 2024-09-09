{
  description = "A nixpkgs overlay for homebrew development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;

    systems = lib.systems.flakeExposed;
    forAllSystems = fn:
      lib.genAttrs systems (system:
        fn {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        });
  in rec {
    formatter = forAllSystems ({pkgs, ...}: pkgs.alejandra);

    legacyPackages = forAllSystems ({pkgs, ...}: (pkgs.callPackage ./pkgs {}));

    hydraJobs = {
      inherit
        (legacyPackages)
        x86_64-linux
        aarch64-linux
        ;
      # FIXME Darwin builders pls 🥺
    };

    overlays.default = import ./overlay.nix;
  };
}
