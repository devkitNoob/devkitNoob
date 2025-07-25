# File was originally copied with permission from
# github:ihaveamac/nur-packages and then modified.
{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "3dstools";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    hash = "sha256-2JVtsyFi42sEEZf13Ei+tuLSD4u58IO3xj4bMZtq3zM=";
  };

  nativeBuildInputs = [
    autoconf
    automake
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "Tools for 3DS homebrew";
    homepage = "https://github.com/devkitpro/3dstools";
    platforms = lib.platforms.unix;
  };
})
