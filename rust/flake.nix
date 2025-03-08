{
  description = "rust template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    naersk.url = "github:nix-community/naersk";
    fenix.url = "github:nix-community/fenix";
  };

  outputs =
    {
      fenix,
      flake-utils,
      naersk,
      nixpkgs,
      self,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [ fenix.overlays.default ];
        };

        name = "rust-template";

        naersk' = pkgs.callPackage naersk { };

        nativeBuildInputs = with pkgs; [
          pkg-config
        ];

        buildInputs = with pkgs; [
          (pkgs.fenix.stable.withComponents [
            "cargo"
            "clippy"
            "rust-src"
            "rustc"
            "rustfmt"
          ])
          rust-analyzer
        ];
      in
      {
        defaultPackage = naersk'.buildPackage {
          src = ./.;
        };

        devShells.default = pkgs.mkShell {
          inherit name nativeBuildInputs buildInputs;

          shellHook = ''
            export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
          '';
        };
      }
    );
}
