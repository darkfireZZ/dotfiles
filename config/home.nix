{ config, lib, pkgs, ... }:

let
  username = "darkfire";
  home_dir = "/Users/darkfire";
  dotfiles_dir = "${home_dir}/.dotfiles";
  theme = "tomorrow-night-eighties";
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };
  nixpkgs-firefox-darwin = builtins.fetchGit {
    url = "https://github.com/bandithedoge/nixpkgs-firefox-darwin";
    ref = "main";
  };

  python = pkgs.python3Full;
  pythonWithPackages = python.withPackages (pythonPkgs: with pythonPkgs; [
    pip
  ]); 

  tactful = pkgs.rustPlatform.buildRustPackage rec {
    pname = "tactful";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "darkfireZZ";
      repo = pname;
      rev = version;
      sha256 = "sha256-djnuRIhbdSdd/EqKTrWSZDAqghFiQFBIg9Z49HURckk=";
    };

    cargoSha256 = "sha256-lBPGYDvoVzCc5CUD76LIxBoW+u9+ZkANy27PITprAfQ=";
  };
in {
  home = {
    username = "${username}";
    homeDirectory = "${home_dir}";
  };

  # TODO return to use only free packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # files stuff
    bat
    exa
    fd
    jq
    ripgrep
    # dev
    neovim
    pythonWithPackages
    tokei
    rustup
    # other things
    curl
    htop
    hyperfine
    imagemagick
    poppler_utils
    tactful
    texlive.combined.scheme-full
  ];

  # neovim config
  home.file."${config.xdg.configHome}/nvim" = {
    source = "${dotfiles_dir}/config/nvim";
  };

  # tactful config
  home.file."${config.xdg.configHome}/tactful.toml" = {
    text = ''store_path = "${home_dir}/priv/contacts.json"'';
  };
  
  nixpkgs.overlays = [
    (import "${nixpkgs-firefox-darwin}/overlay.nix")
  ];

  programs = {
    bash = {
      enable = true;
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
      profiles.default = {
        isDefault = true;
        extensions = with nur.repos.rycee.firefox-addons; [
          # ad blocker
          ublock-origin
          # allows you to access paywalled web pages
          # bypass-paywalls-clean # currently not working, TODO fix
          # hide cookie banners
          istilldontcareaboutcookies
          # allows finer control of video speed
          videospeed
          # Vim keebindings for firefox
          tridactyl
          # hide suggestions, comments and other distractions on youtube
          youtube-recommended-videos
        ];
        search = {
          force = true;
          engines = {
            "Brave" = {
              urls = [{
                template = "https://search.brave.com/search?q={searchTerms}";
              }];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "eBay".metaData.hidden = true;
          };
          default = "Brave";
          order = [
            "Brave"
            "Google"
            "Bing"
          ];
        };
        settings = {
          "browser.startup.homepage" = "about:home";
          # Don't show warning when opening about:config
          "browser.aboutConfig.showWarning" = false;
          # Disable firefox pocket
          "extensions.pocket.enabled" = false;
          "privacy.trackingprotection.enabled" = true;
          # Disable autofill of forms
          "browser.formfill.enable" = false;
          # Don't ask to save logins and passwords for websites
          "signon.rememberSignons" = false;
          # Disable page history
          "places.history.enabled" = false;
          # Hide firefox view
          "browser.tabs.firefox-view" = false;
          # Always ask where to save downloads
          "browser.download.useDownloadDir" = false;
          # Don't allow Mozilla to install studies
          "app.shield.optoutstudies.enabled" = false;
          # Always hide the booksmarks toolbar
          "browser.toolbars.bookmarks.visibility" = "never";
          # Don't show suggested pages on about:home
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          # Hide toolbar on the top if in fullscreen mode
          "browser.fullscreen.autohide" = true;

          # Clear most browser data when closing firefox
          "privacy.clearOnShutdown.cache" = true;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown.sessions" = true;
          "privacy.clearOnShutdown.siteSettings" = true;
        };
      };
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

    kitty = {
      enable = true;
      settings = {
        remember_window_size = "yes";
        window_margin_width = 7;
        hide_window_decorations = "titlebar-only";
      };
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        format = lib.strings.concatStrings [
          "[┌──\\($username$hostname\\)-\\[$directory\\]$git_branch\n](green)"
          "[└─[\\$](bold blue)](bold green) "
        ];
        directory = {
          format = "[$path]($style)";
          style = "white";
        };
        username = {
          format = "[$user]($style)";
          style_user = "bold blue";
          style_root = "bold red";
          show_always = true;
        };
        hostname = {
          ssh_only = true;
          format = "[@$hostname]($style)";
          style = "bold blue";
        };
        git_branch = {
          format = " on [$branch(:$remote_branch)]($style)";
          style = "bold purple";
        };
      };
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

        # exa
        l = "exa";
        la = "exa --long --all";
        al = "la";                   # also work in case of typo
        tree = "exa --tree";

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
  home.stateVersion = "23.11";
}
