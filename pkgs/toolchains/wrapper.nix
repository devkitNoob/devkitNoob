{
  lib,
  stdenvNoCC,
  makeBinaryWrapper,
  unwrapped,
}:
stdenvNoCC.mkDerivation {
  pname = unwrapped.pname + "-wrapped";
  inherit (unwrapped) version;

  nativeBuildInputs = [makeBinaryWrapper];

  dontUnpack = true;
  dontPatch = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/bin
    ln -s ${lib.escapeShellArg unwrapped}/bin/* "$out/bin"

    for program in "$out"/bin/*-{gcc,g++,c++}; do
      wrapProgram "$program" --argv0 ""
    done
  '';

  passthru = {
    inherit unwrapped;
  };

  inherit (unwrapped) meta;
}
