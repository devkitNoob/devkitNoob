{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  freeimage,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "dstools";
  version = "1.3.3";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "807da5d15033790f9cd15b7cc1172a79cb5ac4bc";
    hash = "sha256-ssjJ3bOZYRGEt9i2JMQUSQoyVJZUVtL3ybmhwUnfcQM=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    autoconf
    automake
    freeimage
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "";
    homepage = "https://github.com/devkitNoob-mirrors/dstools";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "dstools";
    platforms = lib.platforms.unix;
  };
})
