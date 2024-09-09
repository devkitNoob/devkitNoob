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
  }
)
