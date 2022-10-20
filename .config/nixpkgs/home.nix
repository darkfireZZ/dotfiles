{ config, pkgs, ... }:

{
  home.username = "nicolabruhin";
  home.homeDirectory = "/Users/nicolabruhin";

  home.packages = [
    # files stuff
    pkgs.bat
    pkgs.exa
    pkgs.fd
    # dev
    pkgs.neovim
    pkgs.tokei
    # other things
    pkgs.curl
    pkgs.htop
    pkgs.hyperfine
    pkgs.texlive.combined.scheme-medium
    pkgs.zsh
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
