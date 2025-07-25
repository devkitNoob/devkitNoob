{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  freeimage,
  pkg-config,
  zlib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "wut-tools";
  version = "1.3.5";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    rev = "b22de1a3c0c8950c4ad4b4df170c89c05d3196aa";
    hash = "sha256-SqAb/5afw/OQ9A4kSLkPvinGpxyljfX+AfgaqQdeB1U=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
    zlib.dev
  ];

  buildInputs = [
    freeimage
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "Tools for wut";
    homepage = "https://github.com/devkitNoob-mirrors/wut-tools";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "wut-tools";
    platforms = lib.platforms.unix;
  };
})
