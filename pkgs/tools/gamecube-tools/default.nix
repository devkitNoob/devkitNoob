{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  freeimage,
  libGL,
}:
stdenv.mkDerivation (finalAttrs: {
  version = "unstable-2024-09-09";
  pname = "gamecube-tools";

  nativeBuildInputs = [autoreconfHook];
  buildInputs = [
    (freeimage.overrideAttrs (old: {
      meta =
        old.meta
        // {
          # We know about these, but accept the risk
          knownVulnerabilities = [];
        };
    }))
    libGL
  ];

  src = fetchFromGitHub {
    owner = "extremscorner";
    repo = "gamecube-tools";
    #rev = "v${finalAttrs.version}";
    rev = "2eecc969b974535746c61bf948b7e00cf93dbc18";
    hash = "sha256-hTJh9Jgk9bI6VrQUPBNgHOwCaf8Q37uhcPw8Jr0xdAU=";
  };

  meta = {
    description = " Tools for GameCube and Wii projects";
    homepage = "https://github.com/extremscorner/gamecube-tools";
    license = lib.licenses.gpl2;
    maintainers = [dkn.maintainers.novenary];
  };
})
