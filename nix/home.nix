{ config, lib, pkgs, ... }:
let
  home_dir = "/home/darkfire";
in
lib.attrsets.recursiveUpdate (
let
  username = "darkfire";
  dotfiles_dir = "${home_dir}/.dotfiles";
  theme = "tomorrow-night-eighties";

  python = pkgs.python3Full;
  pythonWithPackages = python.withPackages (pythonPkgs: with pythonPkgs; [
    pip
  ]); 

  base16_shell = fetchGit {
    url = "https://github.com/chriskempson/base16-shell";
    ref = "master";
  };

  custom_pinentry = pkgs.pinentry.override {
    enabledFlavors = [ "tty" ];
  };

  # tactful = pkgs.rustPlatform.buildRustPackage rec {
  #   name = "tactful";
  # 
  #   src = pkgs.fetchFromGitHub {
  #     owner = "darkfireZZ";
  #     repo = "tactful";
  #     rev = "dad531b504ecd15cd0ff8b631f8b468fd44cdd84";
  #     sha256 = "sha256-pdUtAgwL8qS5Mv2W+MZqkUezWARFzkB4HCWDVEYNMsA=";
  #   };
  # 
  #   cargoSha256 = "sha256-PaRBhrJnOzt4T6alb/bPC2JP04cPYekEXGOMbJX/EYg=";
  # };
in {
  home = {
    username = "${username}";
    homeDirectory = "${home_dir}";
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "veracrypt"
  ];

  home.packages = with pkgs; [
    acpi
    bashInteractive
    bat
    curl
    dig
    elinks
    eza
    feh
    file
    gnumake
    gnupg
    jq
    keepassxc
    mutt
    ncspot
    neovim
    nmap
    pass
    custom_pinentry
    pythonWithPackages
    ripgrep
    rustup
    starship
    # tactful
    texlive.combined.scheme-full
    tokei
    poppler_utils
    unzip
    veracrypt
    zathura
    zip
    (pkgs.nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

  # neovim config
  home.file."${config.xdg.configHome}/nvim" = {
    source = "${dotfiles_dir}/home/.config/nvim";
  };

  # feh config
  home.file."${config.xdg.configHome}/feh" = {
    source = "${dotfiles_dir}/home/.config/feh";
  };

  # starship config
  home.file."${config.xdg.configHome}/starship.toml" = {
    source = "${dotfiles_dir}/home/.config/starship.toml";
  };

  home.file."${config.xdg.configHome}/ncspot" = {
    source = "${dotfiles_dir}/home/.config/ncspot";
    recursive = true;
  };

  home.file."${config.xdg.configHome}/base16-shell" = {
    source = base16_shell;
  };

  home.file.".bashrc" = {
    source = "${dotfiles_dir}/home/.bashrc";
  };

  home.file.".mutt" = {
    source = "${dotfiles_dir}/home/.mutt";
    recursive = true;
  };

  # fonts
  fonts.fontconfig.enable = true;

  programs = {
    git = {
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

    home-manager = {
      enable = true;
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
  home.stateVersion = "23.05";
}) (import ./firefox/firefox.nix { inherit pkgs home_dir; })
