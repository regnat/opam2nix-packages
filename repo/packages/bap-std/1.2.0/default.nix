world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs.clang or null) (pkgs.gmp or null) (pkgs.libgmp-dev or null)
        (pkgs.libzip or null) (pkgs.libzip-dev or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      bap-future = opamSelection.bap-future;
      base-unix = opamSelection.base-unix;
      camlzip = opamSelection.camlzip;
      core_kernel = opamSelection.core_kernel;
      fileutils = opamSelection.fileutils;
      graphlib = opamSelection.graphlib;
      oasis = opamSelection.oasis;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
      ppx_jane = opamSelection.ppx_jane;
      regular = opamSelection.regular;
      uri = opamSelection.uri;
      utop = opamSelection.utop;
      uuidm = opamSelection.uuidm;
      zarith = opamSelection.zarith;
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
  name = "bap-std-1.2.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "bap-std";
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
    sha256 = "033s16s0igrhqppjarv101483p8fbpwnn0mm64f9gmipc9m5x661";
    url = "https://github.com/BinaryAnalysisPlatform/bap/archive/v1.2.0.tar.gz";
  };
}

