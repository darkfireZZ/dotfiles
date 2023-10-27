{ pkgs, home_dir }:
let
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };
  firefox_dir = "${home_dir}/.mozilla/firefox";
  default_profile_path_relative = "profiles/default";

  user_js = pkgs.stdenv.mkDerivation {
    name = "user.js";
    builder = "${pkgs.bash}/bin/bash";
    args = [ ./user_js_builder.sh ];
    system = builtins.currentSystem;
    overrides = ./user-overrides.js;
    arkenfox_user_js = pkgs.fetchurl {
      # This URL refers to v118 of arkenfox
      url = "https://raw.githubusercontent.com/arkenfox/user.js/3fdcb28b8f1992b66e43582810488413b39ebdb3/user.js";
      hash = "sha256-rWFgnARpraFfuuw6dkWlcoofct1PLFto5rqcbflgQPE=";
    };
    coreutils = pkgs.coreutils;
  };
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    profiles.default = {
      path = "${default_profile_path_relative}";
      isDefault = true;
      extensions = with nur.repos.rycee.firefox-addons; [
        # ad blocker
        ublock-origin
        # allows access to paywalled web pages
        bypass-paywalls-clean
        # hide cookie banners
        istilldontcareaboutcookies
        # allows finer control of video speed
        videospeed
        # Vim keebindings for firefox
        tridactyl
      ];
    };
  };

  home.file = {
    "${firefox_dir}/${default_profile_path_relative}/user.js".source = "${user_js}";

    # Configuring the default search engine using programs.firefox did not work
    # Simply copying the config (in ugly binary format) is a simple workaround.
    "${firefox_dir}/${default_profile_path_relative}/search.json.mozlz4" = {
      source = ./search.json.mozlz4;
      force = true;
    };
  };
}
