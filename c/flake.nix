{
  description = "c template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        name = "template";

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
      }
    );
}
