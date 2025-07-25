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
    owner = "devkitpro";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "054d507f90d32784274b6cf7e03f1c43d02d7a57";
    hash = "sha256-8I0RbrLVUy/+klEQnsPvXWQYx5I49QGjqqw33RLzkOY=";
  };

  NIX_CFLAGS_COMPILE = [ "-std=c++11" ];

  nativeBuildInputs = [
    autoconf
    automake
  ];

  # TODO: Reinstate gbalzss.
  # Need to remove references to gbalzss since otherwise, the build fails
  # very early on.
  # Likely needs patch to fix build.
  preConfigure = ''
    rm src/gbalzss.cpp
    substituteInPlace Makefile.am \
      --replace-fail "gbalzss_SOURCES" "# gbalzss_SOURCES" \
      --replace-fail " gbalzss" ""
    ./autogen.sh
  '';

  /*
  preConfigure = ''
    ./autogen.sh
  '';
  */

  meta = {
    description = "";
    homepage = "https://github.com/devkitpro/gba-tools";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "gba-tools";
    platforms = lib.platforms.unix;
  };
})
