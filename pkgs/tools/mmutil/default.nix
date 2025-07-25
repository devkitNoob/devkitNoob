{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "mmutil";
  version = "1.10.1";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-m0oPXSaI3dVTvHjLuxfbguEDqq7buKok2tzcKGZ0mKk=";
  };

  nativeBuildInputs = [
    autoreconfHook
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "";
    homepage = "https://github.com/devkitNoob-mirrors/mmutil";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "mmutil";
    platforms = lib.platforms.unix;
  };
})
