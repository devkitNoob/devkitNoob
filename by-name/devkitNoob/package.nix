{
  lib,
  newScope,
}:
lib.makeScope newScope (
  self: let
    inherit (self) callPackage;
  in {
    inherit
      (callPackage ../../pkgs/toolchains {})
      noobkitARM
      noobkitPPC
      noobkitA64
      ;

    gamecube-tools = callPackage ../../pkgs/tools/gamecube-tools {};
    general-tools = callPackage ../../pkgs/tools/general-tools {};
  }
)
