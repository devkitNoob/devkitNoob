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
      dontRecurseIntoAttrs
      filterAttrs
      genAttrs
      isAttrs
      isDerivation
      mapAttrs
      recurseIntoAttrs
      ;

    forAllSystems = genAttrs systems;
    systems = lib.systems.flakeExposed;
    getDerivations = attrs: let
      sets = filterAttrs (k: v: isDerivation v || (isAttrs v && v.recurseForDerivations or false)) attrs;
    in
      mapAttrs (k: v:
        if isDerivation v
        then v
        else getDerivations v)
      sets;
  in {
    formatter = forAllSystems (system: let
      legacyPackages' = self.legacyPackages.${system};
      inherit (legacyPackages') nixpkgs;
    in
      nixpkgs.alejandra);

    legacyPackages = forAllSystems (system: let
      nixpkgs = dontRecurseIntoAttrs (import inputs.nixpkgs {
        inherit system;
        overlays = [
          self.overlays.default
        ];
      });
    in
      {inherit nixpkgs;} // nixpkgs.devkitNoob);

    hydraJobs = let
      packages = recurseIntoAttrs {
        inherit
          (self.legacyPackages)
          x86_64-linux
          aarch64-linux
          ;
        # FIXME Darwin builders pls 🥺
      };
    in {
      packages = getDerivations packages;
    };

    overlays.default = import ./overlay.nix;
  };
}
