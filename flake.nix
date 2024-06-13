{
  description = "A flake for building mesonlsp";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.default = pkgs.stdenv.mkDerivation rec {
          name = "mesonlsp";
          version = "4.2.2";
          srcs = [
            (pkgs.fetchFromGitHub {
              name = "mesonlsp";
              owner = "JCWasmx86";
              repo = "mesonlsp";
              rev = "v${version}";
              hash = "sha256-pN8MCqrRfVpmM8KWa7HPTghoegplM4bP/HRVJVs05iE=";
            })
            (pkgs.fetchFromGitHub {
              name = "tree-sitter-meson";
              owner = "JCWasmx86";
              repo = "tree-sitter-meson";
              rev = "09665faff74548820c10d77dd8738cd76d488572";
              hash = "sha256-ice2NdK1/U3NylIQDnNCN41rK/G6uqFOX+OeNf3zm18=";
            })
            (pkgs.fetchFromGitHub {
              name = "tree-sitter-ini";
              owner = "JCWasmx86";
              repo = "tree-sitter-ini";
              rev = "20aa563306e9406ac55babb4474521060df90a30";
              hash = "sha256-1hHjtghBIf7lOPpupT1pUCZQCnzUi4Qt/yHSCdjMhCU=";
            })
            (pkgs.fetchFromGitHub {
              name = "sha256";
              owner = "amosnier";
              repo = "sha-2";
              rev = "49265c656f9b370da660531db8cc6bf0a2e110a6";
              hash = "sha256-X9M/ZATYXUiE4oGorPBnsdaKnKaObarnMRh6QEfkBls=";
            })
            (pkgs.fetchFromGitHub {
              name = "ada";
              owner = "ada-url";
              repo = "ada";
              rev = "v2.7.4";
              hash = "sha256-V5LwL03x7/a9Lvg1gPvgGipo7IICU7xyO2D3GqP6Lbw=";
            })
            (pkgs.fetchFromGitHub {
              name = "muon";
              owner = "JCWasmx86";
              repo = "muon";
              rev = "a9bd9889cf0c4849da1c6150c8d6558817655364";
              hash = "sha256-elaEqP/mVA7FsxkDSs4B5lCF6ZbKEZ4mNpXP3remDHU=";
            })
          ];

          sourceRoot = "mesonlsp";

          patchPhase = ''
            patchShebangs ./src/**/*.py
          '';

          preConfigure = ''
            cp -r ./subprojects/packagefiles/* ./subprojects/
            cp -r ../tree-sitter-meson ./subprojects
            cp -r ../tree-sitter-ini ./subprojects
            cp -r ../sha256 ./subprojects
            cp -r ../ada ./subprojects
            cp -r ../muon ./subprojects
          '';

          nativeBuildInputs = with pkgs; [
            meson
            ninja
            cmake
            pkg-config
            python3
          ];

          buildInputs = with pkgs; [
            tree-sitter
            nlohmann_json
            curl
            libarchive
            libuuid
            libpkgconf
            gtest
            libunwind
            tomlplusplus
          ];

          mesonFlags = [
            "-Duse_own_tree_sitter=false"
          ];
        };
      }
    );
}
