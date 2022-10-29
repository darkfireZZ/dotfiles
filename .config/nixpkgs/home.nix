{ config, pkgs, ... }:

{
  home = {
    username = "nicolabruhin";
    homeDirectory = "/Users/nicolabruhin";
  };

  home.packages = with pkgs; [
    # files stuff
    bat
    exa
    fd
    ripgrep
    # dev
    neovim
    tokei
    python310Packages.grip
    # other things
    curl
    htop
    imagemagick
    hyperfine
    texlive.combined.scheme-medium
    zsh
  ];

  programs.git = {
    enable = true;
    aliases = {
      s = "status";
      d = "diff";
    };
    userEmail = "64635413+darkfireZZ@users.noreply.github.com";
    userName = "darkfireZZ";
    extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
    };
  };

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
