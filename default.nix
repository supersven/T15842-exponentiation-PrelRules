{ mkDerivation, base, stdenv }:
mkDerivation {
  pname = "T15842-exponentiation-PrelRules";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base ];
  homepage = "https://github.com/supersven/ghc-experiments";
  description = "Some experiments for solving GHC #15842";
  license = stdenv.lib.licenses.bsd2;
}
