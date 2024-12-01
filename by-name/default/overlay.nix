final: prev: let
  inherit (final) callPackage lib;
  inherit (lib) recurseIntoAttrs;
in {
  devkitNoob = recurseIntoAttrs (callPackage ../devkitNoob/package.nix {});
  lib = prev.lib.extend (import ./lib-overlay.nix);
}
