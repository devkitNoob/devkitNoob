{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  bison,
  flex,
  meson,
  ninja,
  python3Packages,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "uam";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = finalAttrs.pname;
    rev = "5a5afc2bae8b55409ab36ba45be63fcb73f68993";
    hash = "sha256-XwPZixiULM+QPRl9Z+0YMzFYOxznJCSTLg9wNkOswvk=";
  };

  postPatch = ''
    substituteInPlace meson.build --replace-fail distutils packaging
    substituteInPlace meson.build --replace-fail StrictVersion Version
  '';

  nativeBuildInputs = [
    bison
    flex
    meson
    ninja
    python3Packages.mako
    python3Packages.packaging
  ];

  meta = {
    description = "Shader compiler for Nintendo Switch, targeting the deko3d API (based on mesa/nouveau sources";
    homepage = "https://github.com/devkitPro/uam";
    license = [
      lib.licenses.mit  # Everything in ${src}/mesa-imported/
      lib.licenses.zlib # Everything else
    ];
    maintainers = with lib.maintainers; [ ];
    mainProgram = "uam";
    platforms = lib.platforms.unix;
  };
})
