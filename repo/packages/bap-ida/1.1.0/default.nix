world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      bap-ida-plugin = opamSelection.bap-ida-plugin;
      bap-ida-python = opamSelection.bap-ida-python;
      conf-ida = opamSelection.conf-ida;
      core_kernel = opamSelection.core_kernel;
      fileutils = opamSelection.fileutils;
      oasis = opamSelection.oasis;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_jane = opamSelection.ppx_jane;
      re = opamSelection.re;
    };
    opamSelection = world.opamSelection;
    pkgs = world.pkgs;
in
pkgs.stdenv.mkDerivation 
{
  buildInputs = inputs;
  buildPhase = "${opam2nix}/bin/opam2nix invoke build";
  configurePhase = "true";
  installPhase = "${opam2nix}/bin/opam2nix invoke install";
  name = "bap-ida-1.1.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "bap-ida";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "1ms95m4j1qrmy7zqmsn2izh7gq68lnmssl7chyhk977kd3sxj66m";
    url = "https://github.com/BinaryAnalysisPlatform/bap/archive/v1.1.0.tar.gz";
  };
}

