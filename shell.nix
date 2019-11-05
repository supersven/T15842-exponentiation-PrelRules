{ compiler ? "ghc865", pkgs ? import <nixpkgs> {} }:

let
  haskellPackages = pkgs.haskell.packages.${compiler};

  myPackage = haskellPackages.callPackage ./default.nix {};
  ghcide = if compiler == "ghc865" then
    [(import (builtins.fetchTarball "https://github.com/hercules-ci/ghcide-nix/tarball/master") {})."ghcide-${compiler}"]
           else
             [];
in
pkgs.lib.overrideDerivation myPackage.env (old: {
    buildInputs = old.buildInputs ++ [ pkgs.cabal-install pkgs.numactl ] ++ ghcide;
})
