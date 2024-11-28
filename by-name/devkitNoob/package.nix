{
  lib,
  newScope,
}:
lib.makeScope newScope (
  self: let
    inherit (self) callPackage;
  in {
    dkn = {
      maintainers = import ../../pkgs/maintainer-list.nix;
    };

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
