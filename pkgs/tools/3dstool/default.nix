# File was originally copied with permission from
# github:ihaveamac/nur-packages and then modified.
{
  dkn,
  lib,
  openssl,
  libiconv,
  curl,
  stdenv,
  cmake,
  clang,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "3dstool";
  version = "1.2.6";

  src = fetchFromGitHub {
    owner = "dnasdw";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    sha256 = "sha256-YHSuayvFpJHr42ezn1P5OR4Gtp+M6nZL1+ko6hWFvR0=";
  };

  buildInputs = [
    openssl
    libiconv
    curl
  ];
  nativeBuildInputs = [ cmake ];

  makeFlags = [
    "CC=${stdenv.cc.targetPrefix}cc"
    "CXX=${stdenv.cc.targetPrefix}c++"
  ];
  cmakeFlags = [ "-DUSE_DEP=OFF" ];
  enableParallelBuilding = true;

  # fixes building on linux aarch64 (or anything non-x86_64 probably)
  postPatch = ''
    sed -i 's/-m64//g' CMakeLists.txt
    sed -i 's/-m32//g' CMakeLists.txt

    # god damn case sensitivity
    substituteInPlace src/utility.h \
      --replace-fail Windows.h windows.h
  '';

  installPhase = "
    mkdir $out/bin -p
    cp ../bin/Release/3dstool${stdenv.hostPlatform.extensions.executable} $out/bin
    cp ../bin/ignore_3dstool.txt $out/bin
  ";

  meta = {
    description = "An all-in-one tool for extracting/creating 3ds roms.";
    homepage = "https://github.com/dnasdw/3dstool";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    mainProgram = "3dstool";
  };
})
