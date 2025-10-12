#!/hint/bash
set -eu
set -o pipefail

PATCHDIR="$1"
BUILDSCRIPTDIR="$PWD/buildscripts"
declare basedir
# shellcheck source=/dev/null
source "$BUILDSCRIPTDIR/select_toolchain.sh"

tryPatch() {
	local patch="$BUILDSCRIPTDIR/$basedir/patches/$1.patch"
	if [[ -f "$patch" ]]; then
		echo "applying patch $patch"
		patch -p1 -d "$1" < "$patch"
	fi
}
tryPatch "binutils-$BINUTILS_VER"
tryPatch "gcc-$GCC_VER"
tryPatch "newlib-$NEWLIB_VER"

patch -p1 -d "gcc-$GCC_VER" < "$PATCHDIR/install-info-files-serially.patch"

# shellcheck disable=2016
sed -i "$BUILDSCRIPTDIR/$basedir/scripts/build-gcc.sh" \
	-e 's|$EXTRA_GCC_PARAMS|"${EXTRA_GCC_PARAMS[@]}"|' \
	-e '\|binutils-$BINUTILS_VER/configure|a "${EXTRA_BINUTILS_PARAMS[@]}" '\\\\
