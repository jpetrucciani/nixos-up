{
  description = "NixOS flake to help bootstrap new installs!";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
      ];
    in
    {
      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          buildInputs = with nixpkgs.legacyPackages.${system}; [
            (python3.withPackages (p: with p; [
              psutil
              requests
            ]))
          ];
          shellHook = "exec python3 ${./nixos-up.py}";
        };
      });
    };
}
