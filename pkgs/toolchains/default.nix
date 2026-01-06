{
  lib,
  callPackage,
}: let
  mkToolchain = args: callPackage (import ./generic.nix args) {};
in {
  noobkitARM = mkToolchain rec {
    pname = "noobkitARM";
    version = "67";
    srcs = {
      buildscripts = {
        rev = "devkitARM_r${version}";
        hash = "sha256-jVR/lcZNcnQ61r71f+3bOeyw1RrCuUXQDHxxdQkYZ2E=";
      };
      binutils = {
        version = "2.45.1";
        hash = "sha256-hg2t3skIXLQBEnkTb8itKetTPpRG11JK9/UX3RjwAiQ=";
      };
      gcc = {
        version = "15.2.0";
        hash = "sha256-Q4/ZloJrDIJIWinaA6ctcdbjVBqD7HAt9Ccfb+Al0k4=";
      };
      newlib = {
        version = "4.5.0.20241231";
        hash = "sha256-M/EmBeAFSWWZbCXBOCs+RjsK+ReZAB9buMBjDy7IyFI=";
      };
    };
    variant = 1;
    archName = "ARM";
  };

  noobkitPPC = mkToolchain rec {
    pname = "noobkitPPC";
    version = "47";
    srcs = {
      buildscripts = {
        rev = "devkitPPC_r${version}";
        hash = "sha256-uOitIfNZEyq0NBvE7yz15ttgc9PZdKzApdUhf0AleRQ=";
      };
      binutils = {
        version = "2.44";
        hash = "sha256-9mOQpmH6oRfQD6suec8tydCXtCzClr8/hnfR57RS3Do=";
      };
      gcc = {
        version = "15.1.0";
        hash = "sha256-4rCewhZg8B/s/7cV4BICZSFpQ/A40OSKmGhxPlTwbOo=";
      };
      newlib = {
        version = "4.5.0.20241231";
        hash = "sha256-M/EmBeAFSWWZbCXBOCs+RjsK+ReZAB9buMBjDy7IyFI=";
      };
    };
    variant = 2;
    archName = "PowerPC";
  };

  noobkitA64 = mkToolchain rec {
    pname = "noobkitA64";
    version = "28";
    srcs = {
      buildscripts = {
        rev = "devkitA64_r${version}";
        hash = "sha256-bfZdiP/+FJqy49hqB/QJvChTkL2H5FB9Q8wrjLeWJJo=";
      };
      binutils = {
        version = "2.44";
        hash = "sha256-9mOQpmH6oRfQD6suec8tydCXtCzClr8/hnfR57RS3Do=";
      };
      gcc = {
        version = "15.1.0";
        hash = "sha256-4rCewhZg8B/s/7cV4BICZSFpQ/A40OSKmGhxPlTwbOo=";
      };
      newlib = {
        version = "4.5.0.20241231";
        hash = "sha256-M/EmBeAFSWWZbCXBOCs+RjsK+ReZAB9buMBjDy7IyFI=";
      };
    };
    variant = 3;
    archName = "ARM64";
  };
}
