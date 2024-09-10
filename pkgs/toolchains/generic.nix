# References:
# - https://gcc.gnu.org/install/index.html
{
  pname,
  version,
  srcs,
  variant,
  archName,
}: {
  dkn,
  lib,
  stdenv,
  fetchurl,
  fetchFromGitHub,
  texinfo,
  perl,
  gmp,
  mpfr,
  libmpc,
  isl,
  zlib,
  zstd,
}:
stdenv.mkDerivation (finalAttrs: {
  inherit pname version;

  __structuredAttrs = true;

  srcs = [
    (fetchFromGitHub rec {
      name = repo;
      owner = "devkitNoob-mirrors";
      repo = "buildscripts";
      inherit (srcs.buildscripts) rev hash;
    })
    (fetchurl {
      url = "mirror://gnu/binutils/binutils-${srcs.binutils.version}.tar.bz2";
      inherit (srcs.binutils) hash;
    })
    (fetchurl {
      url = "mirror://gcc/releases/gcc-${srcs.gcc.version}/gcc-${srcs.gcc.version}.tar.xz";
      inherit (srcs.gcc) hash;
    })
    (fetchurl {
      url = "https://sourceware.org/pub/newlib/newlib-${srcs.newlib.version}.tar.gz";
      inherit (srcs.newlib) hash;
    })
  ];
  sourceRoot = ".";

  nativeBuildInputs = [texinfo perl];
  buildInputs = [gmp mpfr libmpc isl zlib zstd];

  hardeningDisable = ["format"];
  env = {
    DKN_NAME = finalAttrs.pname;
    DKN_VERSION = finalAttrs.version;
    DKN_BUGURL = "${finalAttrs.meta.homepage}/issues";
    BUILD_DKPRO_PACKAGE = variant;
  };

  patchPhase = ''
    runHook prePatch
    '${stdenv.shell}' '${./apply_patches.sh}'
    runHook postPatch
  '';
  buildPhase = ''
    runHook preBuild
    export DKN_PREFIX="$prefix"
    '${stdenv.shell}' '${./build.sh}'
    runHook postBuild
  '';
  dontInstall = true;

  meta = {
    description = "Compiler toolchain for homebrew development (${archName} targets)";
    homepage = "https://github.com/devkitNoob/devkitNoob";
    license = [
      # Binutils and GCC
      lib.licenses.gpl3Plus

      # Newlib
      lib.licenses.gpl2Plus
    ];
    maintainers = [dkn.maintainers.novenary];
    platforms = lib.platforms.unix;
  };
})
