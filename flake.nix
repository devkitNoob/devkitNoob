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
      genAttrs
      ;

    forAllSystems = genAttrs systems;
    systems = lib.systems.flakeExposed;
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

    overlays.default = import ./overlay.nix;
  };
}
