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
    owner = "devkitPro";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
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
    homepage = "https://github.com/devkitPro/mmutil";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "mmutil";
    platforms = lib.platforms.unix;
  };
})
