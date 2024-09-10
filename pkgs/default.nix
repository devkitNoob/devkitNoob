{
  lib,
  newScope,
}:
lib.makeScope newScope (
  self: let
    inherit (self) callPackage;
  in {
    inherit
      (callPackage ./toolchains {})
      noobkitARM
      noobkitPPC
      noobkitA64
      ;

    general-tools = callPackage ./tools/general-tools {};
  }
)
