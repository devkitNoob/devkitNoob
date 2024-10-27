final: prev: let
  inherit (final) callPackage lib;
  inherit (lib) recurseIntoAttrs;
in {
  devkitNoob = recurseIntoAttrs (callPackage ./pkgs {});
}
