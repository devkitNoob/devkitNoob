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
  version = "unstable-2024-09-11";
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
    rev = "4a331730e645540bd0c3e6ec284dbc4753acbba4";
    hash = "sha256-LgR1fDcb7KV1fKHtso3Zokr9TJ6gSV9xT/1voCA2xnk=";
  };

  meta = {
    description = " Tools for GameCube and Wii projects";
    homepage = "https://github.com/extremscorner/gamecube-tools";
    license = lib.licenses.gpl2;
    maintainers = [dkn.maintainers.novenary];
  };
})
