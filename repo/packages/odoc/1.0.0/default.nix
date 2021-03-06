world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      bos = opamSelection.bos;
      cmdliner = opamSelection.cmdliner;
      doc-ock = opamSelection.doc-ock;
      doc-ock-html = opamSelection.doc-ock-html;
      doc-ock-xml = opamSelection.doc-ock-xml;
      fpath = opamSelection.fpath;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
      result = opamSelection.result;
      topkg = opamSelection.topkg;
      tyxml = opamSelection.tyxml;
      xmlm = opamSelection.xmlm;
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
  name = "odoc-1.0.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "odoc";
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
    sha256 = "1lkhfd74ffxy3zzjvd3wx90a1mmvwhqa2h5f5ar6sb68db1jqxaj";
    url = "http://github.com/ocaml-doc/odoc/releases/download/v1.0.0/odoc-1.0.0.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

