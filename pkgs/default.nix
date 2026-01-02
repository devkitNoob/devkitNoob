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

    contents-delivery-manager = callPackage ./tools/contents-delivery-manager {};
      # TODO: Figure out proper fix.
      # Requires "switch/result.h" - Adding noobkitA64 to nativeBuildInputs
      # does not appear to fix this issue.
    _3dslink = callPackage ./tools/3dslink {};
    _3dstools = callPackage ./tools/3dstools {};
    dstools = callPackage ./tools/dstools {};
    gamecube-tools = callPackage ./tools/gamecube-tools {};
    gba-tools = callPackage ./tools/gba-tools {};
    general-tools = callPackage ./tools/general-tools {};
    gp2x-tools = callPackage ./tools/gp2x-tools {};
    gp32-tools = callPackage ./tools/gp32-tools {};
    grit = callPackage ./tools/grit {};
    hactool = callPackage ./tools/hactool {};
    mmutil = callPackage ./tools/mmutil {};
    ndstool = callPackage ./tools/ndstool {};
    picasso = callPackage ./tools/picasso {};
    switch-tools = callPackage ./tools/switch-tools {};
    tex3ds = callPackage ./tools/tex3ds {};
    uam = callPackage ./tools/uam {};
    wiiload = callPackage ./tools/wiiload {};
    wut-tools = callPackage ./tools/wut-tools {};
  }
)
