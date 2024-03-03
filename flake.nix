{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    pnpm2nix.url = github:nzbr/pnpm2nix-nzbr;
  };

  outputs = { self, nixpkgs, flake-utils, systems, pnpm2nix, ... }:
    flake-utils.lib.eachSystem (import systems) (system:
      let
        pkgs = import nixpkgs { inherit system; };
        mkCheck = args:
          with pkgs;
          stdenvNoCC.mkDerivation (args // {
            src = ./.;
            doCheck = true;
            phases = [ "checkPhase" ];
          });
          inherit (pnpm2nix.packages.${system}) mkPnpmPackage;
      in {
        checks = {
          lint = mkCheck {
            name = "check-lint";
            nativeBuildInputs = with pkgs.nodePackages; [ pnpm eslint ];
            checkPhase = "pnpm lint";
          };
          format = mkCheck {
            name = "check-format";
            nativeBuildInputs = with pkgs.nodePackages; [ pnpm prettier ];
            checkPhase = "pnpm format:check";
          };
        };
        formatter = pkgs.alejandra;
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ nodejs_20 nodePackages.pnpm ];
          shellHook = ''
            pnpm install
          '';
        };
        packages = rec {
          default = website;
          website = mkPnpmPackage {
            pname = "solarliner.dev";
            version = self.rev or "dirty";
            src = ./.;
            installInPlace = true;
          };
        };
      });
}
