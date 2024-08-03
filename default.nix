{ _compat ? import ./flake-compat.nix
, nixpkgs ? _compat.inputs.nixpkgs
, overlays ? [ ]
, config ? { }
, system ? builtins.currentSystem
, extraConfig ? { }
, pkgs ? nixpkgs
    ({
      inherit system;
      overlays = [ ];
      config = { };
    } // extraConfig)
}:

pkgs.mkShell {
  name = "nixos-up";
  buildInputs = with pkgs; [ (python3.withPackages (p: with p; [ psutil requests ])) ];
  shellHook = "exec python3 ${./nixos-up.py}";
}
