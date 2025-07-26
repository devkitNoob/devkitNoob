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
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "37220c696e873812df41af62d1db0b20c66661fe";
    hash = "sha256-hb8nncZ3AwJq6oDyvas9d9rw0RHPth1q1Chqqd8gwf4=";
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
