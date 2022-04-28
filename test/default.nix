let
  pkgs = (
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.11.tar.gz") { }
  );
  project = import ../default.nix { localCheckout = true; };
  stdenv = pkgs.stdenv;
in
stdenv.mkDerivation {
  name = "test-nix-on-rails";
  buildInputs = [
    project
    ./version-test.sh
  ];
  src = ./.;
  phases = pkgs.lib.optional stdenv.isLinux [ "unpackPhase" ] ++ [ "noPhase" ];
  noPhase = ''
    mkdir $out
    ln -s ${project} $out/project
    ln -s ${./version-test.sh} $out/version-test.sh
    cat <<EOS>> $out/test.sh
#!/bin/sh

sh $out/version-test.sh "$out/nix-on-rails"
EOS
    chmod +x "$out/test.sh"

    sh "$out/test.sh"
  '';
}
