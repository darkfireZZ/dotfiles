# TODO add this again
#   plugins = [
#     {
#       name = "up";
#       file = "up.sh";
#       src = pkgs.fetchFromGitHub {
#         owner = "shannonmoeller";
#         repo = "up";
#         rev = "a1fe10fababd58567880380938fdae6d6b9d5bdf";
#         sha256 = "8379baf90bbc1aee582bb097fa41899f65425f376d521eb8c411b297e9686464";
#       };
#     }
#   ];

export EDITOR=nvim
export VISUAL=$EDITOR

export PAGER="bat --plain"

# ------- PATH ------- #

# add rust's cargo directory to PATH if the directory exists
cargo_dir="$HOME/.cargo/env"
if [ -f "$cargo_dir" ]; then
. $cargo_dir
fi

# load home-manager variables
source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

if [[ $- == *i* ]]
then
    # ========== ALIASES ========== #

    alias e="$EDITOR"

    alias ls="ls --color=auto"      # enable color support for ls

    # eza
    alias l="eza"
    alias la="eza --long --all"
    alias tree="eza --tree"

    # movement
    alias u="up"
    alias cb="cd -"

    # TODO don't hardcode these 2
    alias proj="cd $HOME/proj"
    alias dotfiles="cd $HOME/.dotfiles"

    alias vi="nvim"
    alias vim="nvim"
    alias vimdiff="nvim -d"

    # feh themes
    alias fehthumb="feh --theme thumb"

    BASE16_SHELL="$HOME/.config/base16-shell"
    if [[ -s "$BASE16_SHELL/profile_helper.sh" ]]
    then
        source "$BASE16_SHELL/profile_helper.sh"
    fi

    # TODO fix
    # base16_tomorrow-night-eighties

    # set prompt with starship
    eval "$(starship init bash)"
    # workaround for https://github.com/starship/starship/issues/211
    export STARSHIP_SHELL=""
fi
