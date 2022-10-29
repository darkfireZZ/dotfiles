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

    zsh = {
      enable = true;
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
DOTFILES_DIR=$HOME/.dotfiles

# ------- Terminal Style ------- #
#
# Use a base16 style
# TODO: write better documentation

BASE16_SHELL=$DOTFILES_DIR/"dependencies/base16-shell"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
	base16_tomorrow-night-eighties


# ================================== #
# ======= FUNCTIONAL CONFIGS ======= #
# ================================== #

# ------- Enable Autocompletion ------- #

autoload -Uz compinit
compinit

# ------- Aliases ------- #

# ls & exa
alias ls="ls --color=auto"      # enable color support for ls
alias sl="ls"                   # also work in case of typo

# exa
alias l="exa"
alias la="exa --long --all"
alias al="la"                   # also work in case of typo
alias tree="exa --tree"

# cd
alias cb="cd -"

# recursively remove .DS_Store files (starting at the current directory)
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"

# clear
alias c="clear"                 # alternative for clear

alias plate="template.sh"

# cd to projects dir
alias proj="cd $HOME/proj"
# cd to dotfiles dir
alias dotfiles="cd $DOTFILES_DIR"
# cd to home dir
alias home="cd $HOME"

# update nix install on macos
# taken from the manual (2022/10/17):
# https://nixos.org/manual/nix/stable/installation/upgrading.html
alias update-nix-macos="\
    sudo -i sh -c 'nix-channel --update && \
    nix-env -iA nixpkgs.nix && \
    launchctl remove org.nixos.nix-daemon && \
    launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'"

# ------- History Configs ------- #

HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=2000
setopt HIST_IGNORE_ALL_DUPS     # don't save ANY duplicates in history
setopt HIST_IGNORE_SPACE        # don't save commands starting with a space in history
setopt HIST_REDUCE_BLANKS       # remove suprefluous blanks before writing to history
setopt SHARE_HISTORY            # share history between all sessions

# ------- Miscellaneous Settings ------ #

setopt NOTIFY              # report the status of background jobs immediately
setopt PROMPTSUBST         # enable command substitution in prompt

source $DOTFILES_DIR/dependencies/up.sh

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
