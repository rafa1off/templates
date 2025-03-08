{
  description = "rust template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

        name = "rust-template";

        overrides = (builtins.fromTOML (builtins.readFile (self + "/rust-toolchain.toml")));

        nativeBuildInputs = with pkgs; [
          pkg-config
        ];

        buildInputs = with pkgs; [
          rustup
          rust-analyzer
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          inherit name nativeBuildInputs buildInputs;

          RUSTC_VERSION = overrides.toolchain.channel;

          shellHook = ''
            export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
            export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
          '';
        };
      }
    );
}
