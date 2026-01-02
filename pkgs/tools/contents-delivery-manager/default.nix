{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  noobkitA64,
  hactool
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "contents-delivery-manager";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "switchbrew";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-9AzzHBtK/ZQGUAOB4kGUF9bcexUKbOaS8g/ZyCPsQjE=";
  };

  nativeBuildInputs = [
    # noobkitA64
    autoreconfHook
  ];

  buildInputs = [
    hactool
      # Used at runtime
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "Reimplementation of Nintendo Switch contents-delivery";
    homepage = "https://github.com/switchbrew/contents-delivery-manager";
    license = lib.licenses.isc;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "contents-delivery-manager";
    platforms = lib.platforms.unix;
  };
})
