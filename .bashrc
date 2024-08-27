
if [[ $- == *i* ]]
then
    alias ls='eza'
    alias tree='eza --tree'

    alias proj="cd $HOME/proj"

    alias vim='nvim'

    # Always use the CLI interface of veracrypt
    alias veracrypt='veracrypt --text'

    # Somehow mutt messes up my terminal colors. This is a workaround.
    # https://github.com/neomutt/neomutt/issues/518
    alias mutt='TERM=screen-256color mutt'

    # feh themes
    alias fehthumb="feh --theme thumb"

    BASE16_SHELL="$HOME/.config/base16-shell"
    if [[ -s "$BASE16_SHELL/profile_helper.sh" ]]
    then
        source "$BASE16_SHELL/profile_helper.sh"
    fi

    # set prompt with starship
    eval "$(starship init bash)"
fi
