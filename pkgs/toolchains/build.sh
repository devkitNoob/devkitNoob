#!/hint/bash
# shellcheck disable=2034
set -eu
set -o pipefail

BUILDSCRIPTDIR="$PWD/buildscripts"
declare basedir
# shellcheck source=/dev/null
source "$BUILDSCRIPTDIR/select_toolchain.sh"

BUILDDIR="$PWD"
prefix="$DKN_PREFIX"
export PATH="$prefix/bin:$PATH"

MAKE="make"
export MAKEFLAGS="-j$NIX_BUILD_CORES"
: "${cppflags=}" "${CPPFLAGS=}" "${ldflags=}"
CROSS_GCC_PARAMS=""
CROSS_PARAMS=""
EXTRA_GCC_PARAMS=(
	"--with-bugurl=https://github.com/devkitNoob/devkitNoob/issues"
	"--with-pkgversion=$DKN_NAME release $DKN_VERSION"
)

# Inhibit building mn10200-binutils
: "${MN_BINUTILS_VER=dummy}"
mkdir -p "binutils-$MN_BINUTILS_VER"
mkdir -p mn10200/binutils
touch mn10200/binutils/{configured,built,installed}-binutils

# shellcheck source=/dev/null
source "$BUILDSCRIPTDIR/$basedir/scripts/build-gcc.sh"
