world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      asetmap = opamSelection.asetmap;
      asl = opamSelection.asl;
      astring = opamSelection.astring;
      camlzip = opamSelection.camlzip;
      cmdliner = opamSelection.cmdliner;
      cohttp = opamSelection.cohttp;
      conduit = opamSelection.conduit;
      cstruct = opamSelection.cstruct;
      datakit-server = opamSelection.datakit-server;
      fmt = opamSelection.fmt;
      git = opamSelection.git;
      hvsock = opamSelection.hvsock;
      irmin = opamSelection.irmin;
      irmin-watcher = opamSelection.irmin-watcher;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt;
      mirage-flow = opamSelection.mirage-flow;
      mirage-tc = opamSelection.mirage-tc;
      mirage-types = opamSelection.mirage-types;
      mtime = opamSelection.mtime;
      named-pipe = opamSelection.named-pipe;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
      prometheus-app = opamSelection.prometheus-app;
      result = opamSelection.result;
      rresult = opamSelection.rresult;
      topkg = opamSelection.topkg;
      uri = opamSelection.uri;
      win-eventlog = opamSelection.win-eventlog;
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
  name = "datakit-0.9.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "datakit";
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
    sha256 = "08q2kifg66bh8fnf4971gvlw5c9r78zvq6l9r7x0ng1q9ylkx7d2";
    url = "https://github.com/docker/datakit/releases/download/0.9.0/datakit-0.9.0.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

