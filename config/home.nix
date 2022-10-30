{ config, lib, pkgs, ... }:

let
  username = "nicolabruhin";
  home_dir = "/Users/nicolabruhin";
  dotfiles_dir = "${home_dir}/.dotfiles";
  theme = "tomorrow-night-eighties";
in {
  home = {
    username = "${username}";
    homeDirectory = "${home_dir}";
  };

  home.packages = with pkgs; [
    # files stuff
    bat
    exa
    fd
    ripgrep
    # dev
    tokei
    python310Packages.grip
    # other things
    curl
    htop
    imagemagick
    hyperfine
    texlive.combined.scheme-medium
  ];

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

    kitty = {
      enable = true;
      settings = {
        remember_window_size = "yes";
        window_margin_width = 7;
        hide_window_decorations = "titlebar-only";
      };
    };

    neovim = {
      enable = true;
      # symlink "vi" to nvim
      viAlias = true;
      # symlink "vim" to nvim
      vimAlias = true;
      # symlink "vimdiff" to nvim -d
      vimdiffAlias = true;
      configure = {};
    };

    starship = {
      enable = true;
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
        # ls
        ls = "ls --color=auto";      # enable color support for ls
        sl = "ls";                   # also work in case of typo

        # exa
        l = "exa";
        la = "exa --long --all";
        al = "la";                   # also work in case of typo
        tree = "exa --tree";

        # cd
        cb = "cd -";

        # recursively remove .DS_Store files (starting at the current directory)
        cleanupds = "find . -type f -name '*.DS_Store' -ls -delete";

        # clear
        c = "clear";                 # alternative for clear

	hm = "home-manager -f ${dotfiles_dir}/config/home.nix";

        plate = "template.sh";

        # TODO don't hardcode these 2
        proj = "cd $HOME/proj";
        dotfiles = "cd $HOME/.dotfiles";
        # cd to home dir
        home = "cd $HOME";

        # update nix install on macos
        # taken from the manual (2022/10/17):
        # https://nixos.org/manual/nix/stable/installation/upgrading.html
        update-nix-macos = "\
            sudo -i sh -c 'nix-channel --update && \
            nix-env -iA nixpkgs.nix && \
            launchctl remove org.nixos.nix-daemon && \
            launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'";
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
# Set to the first editor in the following list that is installed on the system
#  - nvim
#  - vim
#  - nano
# Print an error message if none of the editors is found.
if type "nvim" > /dev/null; then
  export EDITOR=nvim
elif type "vim" > /dev/null; then
  export EDITOR=vim
elif type "nano" > /dev/null; then
  export EDITOR=nano
else
  echo "ERROR (from $0): Found none of the following editors: nvim, vim, \
nano" 1>&2
fi

# set $VISUAL to the same editor as $EDITOR
export VISUAL=$EDITOR

# ------- PAGER	------- #

# Set the PAGER environment variable
# Set to the first pager in the following list that is installed on the system
#  - less
#  - more
#  Print an error message if none of the pagers is found.
if type "less" > /dev/null; then
  export PAGER=less
elif type "more" > /dev/null; then
  export PAGER=more
else
  echo "ERROR (from $0): Found none of the following pagers: less, more" 1>&2
fi

# ------- PATH ------- #

# add all the binaries in the dotfiles to PATH
export PATH=$PATH:"$HOME/.dotfiles/bin"

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
  home.stateVersion = "22.05";
}
