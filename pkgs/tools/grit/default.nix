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
  version = "unstable-2023-10-02";

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = finalAttrs.pname;
    rev = "81fc1abd4803cd74a5f6c5674cf8cacff009f550";
    hash = "sha256-m4t6ezFtXS1v63u2ijeEMIuoJnjwInhHfdRKMshUoHU=";
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
    homepage = "https://github.com/devkitPro/grit";
    license = with lib.licenses; [ gpl2Only mit ];
      # Is ${src}/license-fi.txt = GPL2?
      # pkgs.freeimage.meta.license = "GPL" -- Assumming GPL2?
    maintainers = with lib.maintainers; [ ];
    mainProgram = "grit";
    platforms = lib.platforms.unix;
  };
})
