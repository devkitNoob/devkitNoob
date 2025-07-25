{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  pkg-config,
  freetype,
  imagemagick,
  librsvg,
  liblqr1,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "tex3ds";
  version = "unstable-2024-10-13";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    rev = "6d5e8681027d59a13fba95b8ee223e324125704e";
    hash = "sha256-MptKZRq3SxRrcTz4RBmUw9LJ/yRFeqSzTkDii/z0wQc=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    pkg-config
  ];

  buildInputs = [
    freetype.dev
    imagemagick.dev
    librsvg
    liblqr1
  ];

  preConfigure = ''
    export MAGICK_INC=${imagemagick.dev}/include/ImageMagick
    export MAGICK_LIB=${imagemagick.out}/lib
    ./autogen.sh
  '';

  meta = {
    description = "3DS Texture Conversion";
    homepage = "https://github.com/devkitNoob-mirrors/tex3ds";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "tex3ds";
    platforms = lib.platforms.unix;
  };
})
