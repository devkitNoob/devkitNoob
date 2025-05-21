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
  version = "0-unstable-2025-05-13";
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
    rev = "fe67d8bf6e8c2c7f447accf94612767d55122532";
    hash = "sha256-n7w0o0E6VCDqohkAS7obDkTIQG7TpiinpJsktuLU9H4=";
  };

  meta = {
    description = " Tools for GameCube and Wii projects";
    homepage = "https://github.com/extremscorner/gamecube-tools";
    license = lib.licenses.gpl2;
    maintainers = [dkn.maintainers.novenary];
  };
})
