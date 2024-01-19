
# This makes it possible to use the same fixed version of peckycheese in
# home.nix and in nixos-config.nix
#
# TODO: There is probably a more idiomatic way to achieve this

{ pkgs ? import <nixpkgs> {} }:
let
  peckycheese_repo = pkgs.fetchFromGitHub {
    owner = "darkfireZZ";
    repo = "peckycheese";
    rev = "8cd5f3eafb85a4a8bc22fc3f5f57381d33ef562e";
    hash = "sha256-ngU6p02t3kUnWDdSobHFtWdKJP8nUUiCu2fJaLLYmRM=";
  };
in
  import "${peckycheese_repo}"
