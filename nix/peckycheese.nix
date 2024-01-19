
# This makes it possible to use the same fixed version of peckycheese in
# home.nix and in nixos-config.nix
#
# TODO: There is probably a more idiomatic way to achieve this

{ pkgs ? import <nixpkgs> {} }:
let
  peckycheese_repo = pkgs.fetchFromGitHub {
    owner = "darkfireZZ";
    repo = "peckycheese";
    rev = "8f2bb476c4db1240e2e4a5b0c7052e2727ede815";
    hash = "sha256-HrD5qda5+NUVhALix/G4a1pVgiImTSUMkyyOufUtjRQ=";
  };
in
  import "${peckycheese_repo}"
