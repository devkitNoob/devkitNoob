{
  lib,
  callPackage,
}: let
  mkToolchain = args: callPackage (import ./generic.nix args) {};
in {
  noobkitARM = mkToolchain rec {
    pname = "noobkitARM";
    version = "66";
    srcs = {
      buildscripts = {
        rev = "devkitARM_r${version}";
        hash = "sha256-Y8J8Es431nhQlZ1k8GbV6yNsn+/pMUOGSrlXVrVqzAs=";
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
    version = "27";
    srcs = {
      buildscripts = {
        rev = "devkitA64_r${version}";
        hash = "sha256-Zr+BVIUNq2U9UE3/1rGFwKAJr3SNZ85jhsBfk98mgqM=";
      };
      binutils = {
        version = "2.43.1";
        hash = "sha256-vsqsXSleA3WHtjpC+tV/49nXuD9HjrJLZ/nuxdDxhy8=";
      };
      gcc = {
        version = "14.2.0";
        hash = "sha256-p7Obxpy/niWCbFpgqyZHcAH3wI2FzsBLwOKcq+1vPMk=";
      };
      newlib = {
        version = "4.4.0.20231231";
        hash = "sha256-DBZqOeG/CVHfr81olJ/g5LbTZYCB1igvOa7vxjEPLxM=";
      };
    };
    variant = 3;
    archName = "ARM64";
  };
}
