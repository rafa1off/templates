{
  description = "c template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      flake-utils,
      nixpkgs,
      self,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        name = "c-template";

        nativeBuildInputs = with pkgs; [
          zig
          pkg-config
          clang-tools
        ];

        buildInputs = with pkgs; [ ];
      in
      {
        devShells.default = pkgs.mkShell {
          inherit
            name
            nativeBuildInputs
            buildInputs
            ;
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = name;
          version = "0.0.0";
          src = ./.;

          inherit buildInputs nativeBuildInputs;
        };
      }
    );
}
