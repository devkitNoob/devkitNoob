{callPackage}: let
  mkToolchain = args: callPackage (import ./generic.nix args) {};
in {
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
