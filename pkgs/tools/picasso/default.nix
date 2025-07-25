{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "picasso";
  version = "unstable-2023-10-11";

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = finalAttrs.pname;
    rev = "d522455ea59cd5cb9219c699b93eb7750039233c";
    hash = "sha256-H3L3oKwHeCVz5J1UsMh7EpWkM3zdAiKPJ8zaJrWvUWI=";
  };

  nativeBuildInputs = [
    autoconf
    automake
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "Homebrew PICA200 shader assembler";
    homepage = "https://github.com/devkitPro/picasso";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "picasso";
    platforms = lib.platforms.unix;
  };
})
