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
  version = "2.7.1";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "82cf7d95fe904bab54a69c723a9e21a06677f290"
    hash = "sha256-njnjutgcNekhvIPBDzBxGxvugEzxt/dkfon/dTCAH5c=";
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
    homepage = "https://github.com/devkitNoob-mirrors/picasso";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "picasso";
    platforms = lib.platforms.unix;
  };
})
