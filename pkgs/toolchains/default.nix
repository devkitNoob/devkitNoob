{
  lib,
  callPackage,
}: let
  mkToolchain = args: callPackage (import ./generic.nix args) {};
in {
  noobkitARM = mkToolchain rec {
    pname = "noobkitARM";
    version = "65";
    srcs = {
      buildscripts = {
        rev = "devkitARM_r${version}";
        hash = "sha256-HBZX+lEw76GXA05GdjCWMaE/kqO8YJV55rOkVbNyxeQ=";
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
    variant = 1;
    archName = "ARM";
  };

  noobkitPPC = mkToolchain rec {
    pname = "noobkitPPC";
    version = "45.2";
    srcs = {
      buildscripts = {
        rev = "devkitPPC_r${version}";
        hash = "sha256-n5voe1Gc4p7Xn9kO4pfI26aeSQFneyZypnCSYMcO2gw=";
      };
      binutils = {
        version = "2.42";
        hash = "sha256-qlSFDr2lBkxyzU7C2bBWwpQlKZFIY1DZqXqypt/frxI=";
      };
      gcc = {
        version = "13.2.0";
        hash = "sha256-4nXnZEKmBnNBon8Exca4PYYTFEAEwEE1KIY9xrXHQ9o=";
      };
      newlib = {
        version = "4.4.0.20231231";
        hash = "sha256-DBZqOeG/CVHfr81olJ/g5LbTZYCB1igvOa7vxjEPLxM=";
      };
    };
    variant = 2;
    archName = "PowerPC";
  };
}
