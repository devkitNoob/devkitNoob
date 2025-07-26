{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gba-tools";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "054d507f90d32784274b6cf7e03f1c43d02d7a57";
    hash = "sha256-8I0RbrLVUy/+klEQnsPvXWQYx5I49QGjqqw33RLzkOY=";
  };

  NIX_CFLAGS_COMPILE = [ "-std=c++11" ];

  patches = [ ./gbalzss_gcc13.diff ];

  nativeBuildInputs = [
    autoconf
    automake
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "";
    homepage = "https://github.com/devkitNoob-mirrors/gba-tools";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "gba-tools";
    platforms = lib.platforms.unix;
  };
})
