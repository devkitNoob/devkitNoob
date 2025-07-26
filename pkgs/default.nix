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
    _3dstool = callPackage ./tools/3dstool {};
    _3dstools = callPackage ./tools/3dstools {};
    dstools = callPackage ./tools/dstools {};
    gamecube-tools = callPackage ./tools/gamecube-tools {};
    gba-tools = callPackage ./tools/gba-tools {};
      # TODO: Figure out proper fix for gbalzss
      # So. Many. Errors.
    general-tools = callPackage ./tools/general-tools {};
    gp2x-tools = callPackage ./tools/gp2x-tools {};
    gp32-tools = callPackage ./tools/gp32-tools {};
    grit = callPackage ./tools/grit {};
      # TODO: Figure out proper fix.
      /*
        configure.ac:18: error: possibly undefined macro: AC_PROG_LIBTOOL
              If this token and others are legitimate, please use m4_pattern_allow.
              See the Autoconf documentation.
        autoreconf: error: /nix/store/kz7dz3kz0w2hzdq1rixh5qr90w3sn3gj-autoconf-2.72/bin/autoconf failed with exit status: 1
      */
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
