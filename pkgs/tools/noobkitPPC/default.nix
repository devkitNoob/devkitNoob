# References:
# - https://gcc.gnu.org/install/index.html
# - https://github.com/richfelker/musl-cross-make/blob/master/litecross/Makefile
{
  lib,
  stdenv,
  fetchurl,
  fetchFromGitHub,
  gmp,
  mpfr,
  libmpc,
  isl,
  zstd,
}: let
  target = "powerpc-eabi";

  sources = {
    binutils = rec {
      url = "mirror://gnu/binutils/binutils-${version}.tar.bz2";
      version = "2.42";
      hash = "sha256-qlSFDr2lBkxyzU7C2bBWwpQlKZFIY1DZqXqypt/frxI=";
    };
    gcc = rec {
      url = "mirror://gcc/releases/gcc-${version}/gcc-${version}.tar.xz";
      version = "13.2.0";
      hash = "sha256-4nXnZEKmBnNBon8Exca4PYYTFEAEwEE1KIY9xrXHQ9o=";
    };
    newlib = rec {
      url = "ftp://sourceware.org/pub/newlib/newlib-${version}.tar.gz";
      version = "4.4.0.20231231";
      hash = "sha256-DBZqOeG/CVHfr81olJ/g5LbTZYCB1igvOa7vxjEPLxM=";
    };
  };
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "noobkitPPC";
    version = "45.2";

    __structuredAttrs = true;

    srcs = [
      (fetchFromGitHub rec {
        name = repo;
        owner = "devkitNoob-mirrors";
        repo = "buildscripts";
        rev = "devkitPPC_r${finalAttrs.version}";
        hash = "sha256-n5voe1Gc4p7Xn9kO4pfI26aeSQFneyZypnCSYMcO2gw=";
      })
      (fetchurl sources.binutils)
      (fetchurl sources.gcc)
      (fetchurl sources.newlib)
    ];

    sourceRoot = ".";

    patchPhase = ''
      runHook prePatch
      (
        tryPatch() {
          local patch="./buildscripts/dkppc/patches/$1.patch"
          if [[ -f "$patch" ]]; then
            echo "applying patch $patch"
            patch -p1 -d "$1" < "$patch"
          fi
        }
        tryPatch 'binutils-${sources.binutils.version}'
        tryPatch 'gcc-${sources.gcc.version}'
        tryPatch 'newlib-${sources.newlib.version}'
      )
      runHook postPatch
    '';

    buildInputs = [
      gmp
      mpfr
      libmpc
      isl
      zstd
    ];

    configureFlags = [
      "--disable-dependency-tracking"
      "--target=${target}"
    ];

    configureFlagsBinutils = [
      "--disable-nls"
      "--disable-shared"
      "--disable-debug"
      "--enable-poison-system-directories"
      "--enable-plugins"
      "--enable-lto"

      "--enable-deterministic-archives"
    ];

    configureFlagsGcc = [
      "gcc_cv_libc_provides_ssp=yes"
      "CFLAGS_FOR_TARGET=-O2 -ffunction-sections -fdata-sections"
      "CXXFLAGS_FOR_TARGET=-O2 -ffunction-sections -fdata-sections"
      "LDFLAGS_FOR_TARGET="

      "--enable-languages=c,c++,objc,lto"
      "--enable-lto"
      "--with-cpu=750"
      "--disable-nls"
      "--disable-shared"
      "--enable-threads=dkp"
      "--disable-multilib"
      "--disable-libstdcxx-pch"
      "--disable-libstdcxx-verbose"
      "--enable-libstdcxx-time=yes"
      "--enable-libstdcxx-filesystem-ts"
      "--disable-tm-clone-registry"
      "--disable-__cxa_atexit"
      "--disable-libssp"
      "--enable-cxx-flags=-ffunction-sections -fdata-sections"
      "--with-newlib"

      "--with-bugurl=${finalAttrs.meta.homepage}/issues"
      "--with-pkgversion=${finalAttrs.pname} release ${finalAttrs.version}"
    ];

    configureFlagsNewlib = [
      "CFLAGS_FOR_TARGET=-O2 -ffunction-sections -fdata-sections -DCUSTOM_MALLOC_LOCK"
      "--enable-newlib-mb"
      "--enable-newlib-register-fini"
    ];

    enableParallelBuilding = true;
    hardeningDisable = ["format"];

    buildPhase = ''
      mkdir -p build
      cd build

      runHook preBuild

      prependToVar configureFlags "--prefix=$prefix"
      local makeFlags=(
        MAKEINFO=true
        ''${enableParallelBuilding:+-j''${NIX_BUILD_CORES}}
      )
      export PATH="$prefix/bin:$PATH"

      mkdir -p binutils
      pushd binutils
      '../../binutils-${sources.binutils.version}/configure' \
        "''${configureFlags[@]}" "''${configureFlagsBinutils[@]}"
      make "''${makeFlags[@]}"
      make "''${makeFlags[@]}" install
      popd

      mkdir -p gcc
      pushd gcc
      '../../gcc-${sources.gcc.version}/configure' \
        "''${configureFlags[@]}" "''${configureFlagsGcc[@]}"
      make "''${makeFlags[@]}" all-gcc
      make "''${makeFlags[@]}" install-gcc
      popd

      mkdir -p newlib
      pushd newlib
      '../../newlib-${sources.newlib.version}/configure' \
        "''${configureFlags[@]}" "''${configureFlagsNewlib[@]}"
      make "''${makeFlags[@]}"
      make "''${makeFlags[@]}" -j1 install
      popd

      pushd gcc
      make "''${makeFlags[@]}"
      make "''${makeFlags[@]}" install
      popd

      runHook postBuild
    '';

    dontInstall = true;

    meta = {
      description = "Toolchain for Nintendo GameCube & Wii homebrew development";
      homepage = "https://github.com/devkitNoob/devkitNoob";
      license = [
        # Binutils and GCC
        # runtime support libraries are typically LGPLv3+
        lib.licenses.gpl3Plus

        # Newlib
        # arch has "bsd" while gentoo has "NEWLIB LIBGLOSS GPL-2" while COPYING has "gpl2"
        # there are 5 copying files in total
        # COPYING
        # COPYING.LIB
        # COPYING.LIBGLOSS
        # COPYING.NEWLIB
        # COPYING3
        lib.licenses.gpl2Plus
      ];
      # TODO maintainers = [ lib.maintainers.novenary ];
      platforms = lib.platforms.unix;
    };
  })
