# File was originally copied from Nixpkgs, and modified.
{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hactool";
  version = "1.4.0-unstable-2023-10-10";

  src = fetchFromGitHub {
    owner = "SciresM";
    repo = finalAttrs.pname;
    rev = "1d64a83450e025622f3468c28fc4164dad2c5ef6";
    sha256 = "0305ngsnwm8npzgyhyifasi4l802xnfz19r0kbzzniirmcn4082d";
  };

  patches = [ ./musl-compat.patch ];

  preBuild = ''
    mv config.mk.template config.mk
  '';

  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];
  enableParallelBuilding = true;

  installPhase = ''
    install -D hactool${stdenv.hostPlatform.extensions.executable} $out/bin/hactool${stdenv.hostPlatform.extensions.executable}
  '';

  meta = {
    homepage = "https://github.com/SciresM/hactool";
    description = "Tool to manipulate common file formats for the Nintendo Switch";
    longDescription = "A tool to view information about, decrypt, and extract common file formats for the Nintendo Switch, especially Nintendo Content Archives";
    license = lib.licenses.isc;
    maintainers = [ ];
    platforms = lib.platforms.unix;
    mainProgram = "hactool";
  };
})
