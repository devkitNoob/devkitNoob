{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  freeimage,
  pkg-config
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "grit";
  version = "0.8.17";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "81fc1abd4803cd74a5f6c5674cf8cacff009f550";
    hash = "sha256-dIF59akcVaRH5/y7ZQ2FlGIOD8q3RS4bt1k5cEVqtUw=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    freeimage
    pkg-config
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "Game Raster Image Transmogrifier";
    homepage = "https://github.com/devkitNoob-mirrors/grit";
    license = with lib.licenses; [ gpl2Only mit ];
      # Is ${src}/license-fi.txt = GPL2?
      # pkgs.freeimage.meta.license = "GPL" -- Assumming GPL2?
    maintainers = with lib.maintainers; [ ];
    mainProgram = "grit";
    platforms = lib.platforms.unix;
  };
})
