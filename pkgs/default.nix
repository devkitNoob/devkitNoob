{
  lib,
  newScope,
}:
lib.makeScope newScope (
  self: let
    inherit (self) callPackage;
  in {
    dkn = {
      maintainers = import ./maintainer-list.nix;
    };

    inherit
      (callPackage ./toolchains {})
      noobkitARM
      noobkitPPC
      noobkitA64
      ;

    general-tools = callPackage ./tools/general-tools {};
  }
)
