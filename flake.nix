{
  description = "A nixpkgs overlay for homebrew development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: let
    inherit (inputs) self;
    inherit (inputs.nixpkgs) lib;
    inherit
      (lib)
      filterAttrs
      genAttrs
      isAttrs
      isDerivation
      mapAttrs
      recurseIntoAttrs
      ;

    systems = lib.systems.flakeExposed;
    forAllSystems = fn:
      genAttrs systems (system:
        fn {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        });
  in {
    formatter = forAllSystems ({pkgs, ...}: pkgs.alejandra);

    legacyPackages = forAllSystems ({pkgs, ...}: recurseIntoAttrs (pkgs.callPackage ./pkgs {}));

    hydraJobs = let
      packages = recurseIntoAttrs {
        inherit
          (self.legacyPackages)
          x86_64-linux
          aarch64-linux
          ;
        # FIXME Darwin builders pls 🥺
      };
      getDerivations = attrs: let
        sets = filterAttrs (k: v: isDerivation v || (isAttrs v && v.recurseForDerivations or false)) attrs;
      in
        mapAttrs (k: v:
          if isDerivation v
          then v
          else getDerivations v)
        sets;
    in {
      packages = getDerivations packages;
    };

    overlays.default = import ./overlay.nix;
  };
}
