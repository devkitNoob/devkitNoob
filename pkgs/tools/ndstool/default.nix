# File was originally copied from Nixpkgs, and modified.
{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ndstool";
  version = "2.3.1";

  src = fetchFromGitHub {
    owner = "devkitNoob-mirrors";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "76e8b681bb225d945a48852821e03114e6c7ce1c";
    hash = "sha256-121xEmbt1WBR1wi4RLw9/iLHqkpyXImXKiCNnLCYnJs=";
  };

  nativeBuildInputs = [
    autoconf
    automake
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    homepage = "https://github.com/devkitNoob-mirrors/ndstool";
    description = "Tool to unpack and repack nds rom";
    maintainers = [ ];
    license = lib.licenses.gpl3;
    mainProgram = "ndstool";
  };
})
