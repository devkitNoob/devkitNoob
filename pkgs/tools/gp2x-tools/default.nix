{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gp2x-tools";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-DNRxXpVUKw52UTDwu1oA9bV3ouX7JyPDNW2WCLAGm4I=";
  };

  nativeBuildInputs = [
    autoconf
    automake
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "";
    homepage = "https://github.com/devkitPro/gp2x-tools";
    license = with lib.licenses; [ gpl3Only mit ];
    maintainers = with lib.maintainers; [ ];
    mainProgram = "gp2x-tools";
    platforms = lib.platforms.unix;
  };
})
