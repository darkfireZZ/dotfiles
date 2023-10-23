pkgs: pkgs.stdenv.mkDerivation {
  name = "firefox-config-test";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./builder.sh ];
  system = builtins.currentSystem;
  src = ./.;
  arkenfox_user_js = pkgs.fetchurl {
    # This URL refers to v118 of arkenfox
    url = "https://raw.githubusercontent.com/arkenfox/user.js/3fdcb28b8f1992b66e43582810488413b39ebdb3/user.js";
    hash = "sha256-rWFgnARpraFfuuw6dkWlcoofct1PLFto5rqcbflgQPE=";
  };
  curl = pkgs.curl;
  coreutils = pkgs.coreutils;
}
