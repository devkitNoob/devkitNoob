# File was originally copied from Nixpkgs, and modified.
{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  zlib,
}:
stdenv.mkDerivation (finalAttrs: {
  version = "0.5.3";
  pname = "wiiload";

  nativeBuildInputs = [
    autoconf
    automake
  ];
  buildInputs = [ zlib ];

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    # rev = "c74abc7c2d318a39854ab90fdacb0097145fb541";
    sha256 = "sha256-pZdZzCAPfAVucuiV/q/ROY3cz/wxQWep6dCTGNn2fSo=";
  };

  preConfigure = ''
    ./autogen.sh
  '';

  meta = {
    description = "Load homebrew apps over network/usbgecko to your Wii";
    mainProgram = "wiiload";
    homepage = "https://wiibrew.org/wiki/Wiiload";
    license = lib.licenses.gpl2;
    maintainers = with lib.maintainers; [ ];
  };
})
