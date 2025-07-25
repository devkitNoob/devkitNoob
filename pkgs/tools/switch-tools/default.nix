{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  pkg-config,
  lz4,
  zlib
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "switch-tools";
  version = "1.13.1";

  src = fetchFromGitHub {
    owner = "switchbrew";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "22756068dd0ed6ff9734c59cb4f99ebd3f62555b";
    hash = "sha256-WI8sHucTeZOCQWlVdv5fFHK1ENdajUVXlvaW1lJfSMc=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    lz4.dev
    pkg-config
    zlib.dev
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "Helper tools for Switch homebrew development";
    homepage = "https://github.com/switchbrew/switch-tools";
    license = lib.licenses.isc;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "switch-tools";
    platforms = lib.platforms.unix;
  };
})
