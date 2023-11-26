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
    bat
    curl
    eza
    feh
    file
    jq
    keepassxc
    neovim
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

  # tactful config
  home.file."${config.xdg.configHome}/tactful.toml" = {
    text = ''store_path = "${home_dir}/priv/contacts.json"'';
  };

  # neovim config
  home.file."${config.xdg.configHome}/nvim" = {
    source = "${dotfiles_dir}/config/nvim";
  };

  # feh config
  home.file."${config.xdg.configHome}/feh" = {
    source = "${dotfiles_dir}/config/feh";
  };

  # starship config
  home.file."${config.xdg.configHome}/starship.toml" = {
    source = "${dotfiles_dir}/config/starship.toml";
  };

  # fonts
  fonts.fontconfig.enable = true;

  programs = {
    bash = {
      enable = true;
    };

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

    zsh = {
      enable = true;
      completionInit = "autoload -U compinit && compinit";
      history = {
        path = "$HOME/.zsh_history";
        size = 1000;
        save = 2000;
        ignoreDups = true;
        ignoreSpace = true; # don't save commands starting with a space in history
        share = true; # share history between all sessions
      };
      shellAliases = {
        # dev shortcuts
        e = "$EDITOR";
        g = "git";
      
        # ls
        ls = "ls --color=auto";      # enable color support for ls
        sl = "ls";                   # also work in case of typo

        # eza
        l = "eza";
        la = "eza --long --all";
        al = "la";                   # also work in case of typo
        tree = "eza --tree";

        # movement
        u = "up";
        cb = "cd -";

        # recursively remove .DS_Store files (starting at the root directory)
        cleanupds = "find / -type f -name '*.DS_Store' -ls -delete";

        # clear
        c = "clear";                 # alternative for clear

        # TODO don't hardcode these 2
        proj = "cd $HOME/proj";
        dotfiles = "cd $HOME/.dotfiles";

        vi = "nvim";
        vim = "nvim";
        vimdiff = "nvim -d";

        # feh themes
        fehthumb = "feh --theme thumb";
      };
      plugins = [
        {
          name = "up";
          file = "up.sh";
          src = pkgs.fetchFromGitHub {
            owner = "shannonmoeller";
            repo = "up";
            rev = "a1fe10fababd58567880380938fdae6d6b9d5bdf";
            sha256 = "8379baf90bbc1aee582bb097fa41899f65425f376d521eb8c411b297e9686464";
          };
        }
        {
          name = "base16-shell";
          file = "base16-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "tinted-theming";
            repo = "base16-shell";
            rev = "42918118727560723e46fd5e40fe49a5df2f9d30";
            sha256 = "d31ac0d0439d09c012d148456792e0e2353d8b4fc54ef27ebc80f9f1071850cd";
          };
        }
      ];

      envExtra = ''
# Set the EDITOR environment variable
export EDITOR=nvim
# set $VISUAL to the same editor as $EDITOR
export VISUAL=$EDITOR

export PAGER="bat --plain"

# ------- PATH ------- #

# add rust's cargo directory to PATH if the directory exists
cargo_dir="$HOME/.cargo/env"
if [ -f "$cargo_dir" ]; then
    . $cargo_dir
fi

# Make sure that nix is in $PATH
#
# Nix broke after updating my macbook air because this was missing from my
# /etc/zshrc. Fix (or workaround?): add the snippet into this file.
#
# Related issue: https://github.com/NixOS/nix/issues/3616
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
'';
      initExtra = ''
        # set prompt with starship
        eval "$(starship init zsh)"
        base16_${theme}
        setopt NOTIFY              # report the status of background jobs immediately
        setopt PROMPTSUBST         # enable command substitution in prompt
      '';
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
