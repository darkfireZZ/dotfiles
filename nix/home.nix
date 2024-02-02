{ config, lib, pkgs, ... }:
let
  home_dir = "/home/darkfire";
  peckycheese = import ./peckycheese.nix { inherit pkgs; };
in
lib.attrsets.recursiveUpdate (
let
  username = "darkfire";
  dotfiles_dir = "${home_dir}/.dotfiles";

  base16_shell = fetchGit {
    url = "https://github.com/chriskempson/base16-shell";
    ref = "master";
  };

  custom_pass = pkgs.pass.override {
    dmenu = peckycheese.dmenu;
  };

  scripts = pkgs.stdenv.mkDerivation {
    name = "scripts";
    src = ../scripts;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp $src/* $out/bin
    '';
  };
in {
  home = {
    username = "${username}";
    homeDirectory = "${home_dir}";
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "veracrypt"
  ];

  home.packages = with pkgs; [
    peckycheese.anypinentry
    peckycheese.dmenu
    peckycheese.st
    peckycheese.tactful
    peckycheese.urls
    acpi
    bashInteractive
    bat
    curl
    dig
    elinks
    eza
    feh
    figlet
    file
    gcc
    git
    gnumake
    gnupg
    jq
    keepassxc
    mutt
    ncspot
    neovim
    nmap
    openconnect
    pandoc
    custom_pass
    ripgrep
    rustup
    starship
    texlive.combined.scheme-full
    tokei
    poppler_utils
    unzip
    veracrypt
    zathura
    zip
    (pkgs.nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
    scripts
  ];

  home.file = {
    "${config.xdg.configHome}/nvim".source = "${dotfiles_dir}/home/.config/nvim";
    "${config.xdg.configHome}/feh".source = "${dotfiles_dir}/home/.config/feh";
    "${config.xdg.configHome}/git".source = "${dotfiles_dir}/home/.config/git";
    "${config.xdg.configHome}/starship.toml".source = "${dotfiles_dir}/home/.config/starship.toml";
    "${config.xdg.configHome}/ncspot" = {
      source = "${dotfiles_dir}/home/.config/ncspot";
      recursive = true;
    };
    "${config.xdg.configHome}/base16-shell".source = base16_shell;
    ".bashrc".source = "${dotfiles_dir}/home/.bashrc";
    ".gnupg/gpg-agent.conf".source = "${dotfiles_dir}/home/.gnupg/gpg-agent.conf";
    ".mutt" = {
      source = "${dotfiles_dir}/home/.mutt";
      recursive = true;
    };
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
}) (import ./firefox/firefox.nix { inherit pkgs home_dir; })
