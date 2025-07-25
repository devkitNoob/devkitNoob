{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  pkg-config,
  zlib
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "3dslink";
  version = "0.6.3";

  sourceRoot = "${finalAttrs.src.name}/host";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-0muL/vxYn4C9WlGgfsWO7hVsdCC2L5mtpdVvUaOK7f0=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    zlib.dev
    pkg-config
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "";
    homepage = "https://github.com/devkitNoob-mirrors/3dslink";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "3dslink";
    platforms = lib.platforms.unix;
  };
})
