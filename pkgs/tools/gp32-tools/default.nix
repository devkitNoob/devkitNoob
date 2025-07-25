{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  pkg-config,
  zlib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gp32-tools";
  version = "1.0.4";

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    hash = "sha256-o0iflFiFEVBwzb1ElkdM6ExY1CggE/uO/OwheNrfcEs=";
  };

  NIX_CFLAGS_COMPILE = [ "-std=c++11" ];

  nativeBuildInputs = [
    autoconf
    automake
    pkg-config
    zlib.dev
  ];

  # Remove seemingly unused directories (UltraEdit leftovers?) from src dir.
  # Otherwise, make tries to make binaries with the same name,
  # and it fails.
  preConfigure = ''
    rm -r b2fxec gpd zda_compressor
    ./autogen.sh
  '';

  meta = {
    description = "";
    homepage = "https://github.com/devkitPro/gp32-tools";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "gp32-tools";
    platforms = lib.platforms.unix;
  };
})
