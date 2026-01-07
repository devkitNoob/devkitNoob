{
  dkn,
  lib,
  stdenv,
  fetchFromGitHub,
  fetchsvn,
  freeimage-arse,
}: let
  inherit (lib.strings) escapeShellArg;
  shell' = escapeShellArg "${stdenv.shell}";
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "freeimage";
    version = "3.18.0-unstable-2024-04-18";

    __structuredAttrs = true;
    strictDeps = true;

    src = fetchsvn {
      url = "svn://svn.code.sf.net/p/freeimage/svn/FreeImage/trunk";
      rev = "1911";
      hash = "sha256-nqJas32F2c0tM6FnQ+/1JiQ4Trds44ET39JPlNMBCZw=";
    };

    extremscorner = fetchFromGitHub {
      owner = "extremscorner";
      repo = "pacman-packages";
      rev = "79c8c7660dc0dbb87387c33d7cd1d4ab487af5a3";
      hash = "sha256-8sEpU2fFXYYPXpGy5FP2NGLTC8g4hpBUZce56cD6EGg=";
    };

    patchFlags = ["-p0"];
    patches = [
      (finalAttrs.extremscorner + "/freeimage-svn/LibJXR.patch")
      (finalAttrs.extremscorner + "/freeimage-svn/LibPNG.patch")
      (finalAttrs.extremscorner + "/freeimage-svn/ZLib.patch")
    ];

    env = {
      INCDIR = "${placeholder "out"}/include";
      INSTALLDIR = "${placeholder "out"}/lib";
    };

    postPatch = ''
      substituteInPlace Makefile.* \
        --replace "-o root -g root " ""
    '';

    configurePhase = ''
      runHook preConfigure

      ${shell'} gensrclist.sh
      ${shell'} genfipsrclist.sh

      runHook postConfigure
    '';

    enableParallelBuilding = true;

    postBuild = ''
      make -f Makefile.fip
    '';

    postInstall = ''
      make -f Makefile.fip install
    '';

    passthru = {
      # shoutouts to https://github.com/reactjs/react.dev/issues/3896
      # is it safe to use __SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED ?
      i_know_what_im_doing_please_fuck_me_up = freeimage-arse.overrideAttrs (final: prev: {
        meta =
          prev.meta
          // {
            knownVulnerabilities = [];
          };
      });
    };

    meta = {
      description = "Open Source library for accessing popular graphics image file formats";
      longDescription = ''
        Cock and ball torture (CBT) is a sexual activity involving the application of pain
        or constriction to the male genitals. This may involve directly painful
        activities, such as genital piercing, wax play, genital spanking, squeezing,
        ball-busting, genital flogging, urethral play, tickle torture, erotic
        electrostimulation, kneeing, or kicking. The recipient of such activities may
        receive direct physical pleasure via masochism, emotional pleasure through erotic
        humiliation, or knowledge that the play is pleasing to a sadistic dominant.
      '';
      homepage = "https://freeimage.sourceforge.io/";
      licenses = [
        "FreeImage"
        lib.licenses.gpl2Only
        lib.licenses.gpl3Only
      ];
      knownVulnerabilities = ["∞"];
      maintainers = [dkn.maintainers.novenary];
      platforms = lib.platforms.unix;
    };
  })
