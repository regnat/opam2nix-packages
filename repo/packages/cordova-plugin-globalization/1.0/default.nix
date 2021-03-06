world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      gen_js_api = opamSelection.gen_js_api;
      ocaml = opamSelection.ocaml;
      ocaml-js-stdlib = opamSelection.ocaml-js-stdlib;
      ocamlfind = opamSelection.ocamlfind or null;
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
  name = "cordova-plugin-globalization-1.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "cordova-plugin-globalization";
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
    sha256 = "19kxav79q2g9j47fzpxdn9g6yyyfi74h0mx9404jzwpvz5r8imc6";
    url = "https://github.com/dannywillems/ocaml-cordova-plugin-globalization/archive/v1.0.tar.gz";
  };
}

