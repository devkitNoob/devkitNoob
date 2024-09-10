{
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "general-tools";
  version = "1.4.4";

  __structuredAttrs = true;

  nativeBuildInputs = [autoreconfHook];

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    hash = "sha256-clt7IzFg4QOAgqhYiFqI9kD+Z4XOBGCEHgCQBiOtXuQ=";
  };

  meta = {
    description = "Tools for homebrew development";
    homepage = "https://github.com/devkitNoob/devkitNoob";
    license = [
      lib.licenses.gpl2Plus # padbin.c
      lib.licenses.mit # bin2s.c
      lib.licenses.gpl3 # COPYING
    ];
    # TODO maintainers = [ lib.maintainers.novenary ];
    platforms = lib.platforms.unix;
  };
})
